function [bitsPerPixel,bpp,SizeCoded, jpeg_decoded] = jpeg(image, qf)

% CONSTRAINTS: 
% - Input image is a MxN matrix (in grayscale). and its rows.
% - Both rows and columns have to be multiple of 8.

%--------------------------------------------------------------------------
% Image matrix values to double so we can work with negative
% values. For example, 20-100 would be 0 with the input format 'uint8'. We
% need this value to be -80.
x = double(image);
%x=image;
% We ask for the Compression Factor.

%alpha = input('Compression Factor (greater than or equal to 1) = ');

% We get rows and columns matrix size. We're able to calculate how
% many blocks we'll use for rows/columns.

n = size(x,1);
m = size(x,2);

blocsFiles = n/8;
blocsColumnes = m/8;

% Gamma Matrix: 
 G =[ 16 11 10 16 24  40  51  61;
      12 12 14 19 26  58  60  55;
      14 13 16 24 40  57  69  56;
      14 17 22 29 51  87  80  62;
      18 22 37 56 68  109 103 77;
      24 35 55 64 81  104 113 92;
      49 64 78 87 103 121 120 101;
      72 92 95 98 112 100 103 99];
 
if qf < 50
qscale = floor( 5000 / qf ) ;
else
qscale = 200 - 2 * qf ;
end
G = round ( G * qscale / 100 ) ;
% if QF~=100
% 
% 
%  if QF >= 50
%    %  Q = floor(G.*(ones(8)*((100-QF)/50)));
%      S= 200 - 2*QF; 
%      Q=(50+(S.*G))/100;
%      Q = double(Q);
%     
%  elseif QF < 50
%     S=5000./G;
%     Q=(50+(S.*G))/100;
%      Q = double(Q);
%      
%     % Q = floor(G.*(ones(8)*(50/QF)));
%     % Q = double(Q);
%  %elseif QF == 50
%   %   Q = G;
%  %     Q = double(Q);
%  end
%   G=Q;
% end

% Before going block to block through the matrix, we have to initialize
% the previous DC coefficient.
dcAnt = 0;

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%CODIFICATION:

jpeg_coded = char.empty;
 
for i=1:blocsFiles
    for j=1:blocsColumnes
        
        % Going through each block and doing previous operations to get
        % the coefficient values of each block.
        bloc = x(i*8-7:i*8,j*8-7:j*8)-127;
        blocDct = dct2(bloc);
        %% for Pruned (2x2 , 4x4, 6x6) (with remove of line 73)
        %%blocDct2 = dct2(bloc);
        %blocDct=zeros(8);
        %blocDct(1:4,1:4)=blocDct2(1:4,1:4);
        %%
        coef = round(round(blocDct./(G)));
        seqCoef = zigzag(coef);
        
        % DC value:
        dif = seqCoef(1) - dcAnt;
        
        % Encoding DC:
        codeDC = codifDC(dif);
        
        % Encoding AC:
        codeAC = codifAC(seqCoef);
        
        % Updating jpeg_coded bitstream with the current codeBlock.
        codeBlock = [codeDC codeAC];
        jpeg_coded = [jpeg_coded codeBlock];
        
        % Updating the previous DC coefficient.
        dcAnt = seqCoef(1);
        
        % Saving our codification to its position in our coded block
        % matrix:
        coded{i,j} = codeBlock;
    end
end

jpeg_bitstream = jpeg_coded;

SizeCoded=length(jpeg_bitstream)/8000;
bpp=jpeg_bitstream/(64);
bitsPerPixel=length(jpeg_bitstream)/(n*m);

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%DECODIFICATION:

% Now we have a big stream of bits (jpeg_bitstream) which stores all
% information of our coded image. We have to decode it. Then we have to
% create our block matrix decoded again and finally transform it 
% to our new decoded image.

jpeg_decoded = zeros(n,m);

dcAnt = 0;
for i=1:blocsFiles
    for j=1:blocsColumnes
    % In each iteration we have to decode our DC an AC values, and then
    % update our bitstream removing the decoded part. So in each iteration
    % the bitstream will be sorther than the previous one.
    
    % DC Decodification
    seqCoef = char.empty;
    [valor, numBits] = decodifDC(jpeg_bitstream); 
    jpeg_bitstream = jpeg_bitstream(numBits+1:end); 
    coeficient = dcAnt + valor;
    seqCoef = coeficient;
    dcAnt = coeficient;
    
    % AC Decodification
    while (length(seqCoef)<64)

        [coef,numZeros,numBits,EndOfBlock] = decodifAC(jpeg_bitstream); 
        if (EndOfBlock)
            for k=1:(64-length(seqCoef))
                seqCoef = [seqCoef 0];
            end
            jpeg_bitstream = jpeg_bitstream(5:end); 
        else
            for l=1:numZeros
                seqCoef = [seqCoef 0];
            end
            seqCoef = [seqCoef coef];
            jpeg_bitstream = jpeg_bitstream(numBits+1:end);
        end
    end
    % Once we have the sequence of decoded coefficients, we have to do the
    % inverse of what we did when we coded the image in the Codification
    % section. This will place every block where it belongs.
    
    sequencia_decodificada{i,j}=seqCoef;
    
    bloc = izigzag(seqCoef,8,8); 
    bloc = bloc.*(G);
    bloc = round(idct2(bloc)+128); 
    jpeg_decoded(i*8-7:i*8,j*8-7:j*8) = bloc;
    end
end

 jpeg_decoded=double(jpeg_decoded);
end