% JPEGdemo.m
% Prototype JPEG compression algorithm demostration
%
% copyright (c) 1997-2002 by Yu Hen Hu
% 
% This algorithm only demonstrate the basic 
% JPEG functionalities.
% It is not necessarily a faithful 
% implementation of JPEG.
% Its output will not be binary bit streams 
% either, but rather
% an integer stream of 0 and 1s
% Only gray scale picture is considered
% 
% Last modification: 11/6/2002
% Load data
%load MBs
%function [Com_Rate , Com_Ratio , accof, dccof]=Like_JPEG_DTT(MBs)
    load lena.mat

f=x;%(1+128:128+128,1+128:128+128);
    imshow(mat2gray(f))
    clear x

    %  variable f  is taken from the text book.

%echo on

% level shift by 128
f=f-128;
%pause
drawnow
[mf,nf]=size(f); mb=mf/8; nb=nf/8;  
% size of f, # of blocks of f

% Step 1. 2D separable DCT on each 8x8 
% blocks 
    Ff=blkproc(f,[8 8],'dct');  
    % apply DCT to each column of each block of f
    Ff=blkproc(Ff',[8 8],'dct');
    % apply DCT to each row of each block of Ff
    Ff=round(Ff');
    % transpose back to proper orientation

%pause

% Perceptual scaler quantization
%
Q =[16 11 10 16  24  40  51  61
    12 12 14 19  26  58  60  55
    14 13 16 24  40  57  69  56
    14 17 22 29  51  87  80  62
    18 22 37 56  68 109 103  77
    24 35 55 64  81 104 113  92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];
% this is the quantization matrix shown in figure 8.37 in the textbook
%pause
% Now perform rounding

    Fq=round(blkproc(Ff,[8 8],'divq',Q));

%pause
%echo off
% DPCM of DC component, scaned row-wise 
if mb*nb > 1,
   fdc=reshape(Fq(1:8:mf,1:8:nf)',mb*nb,1);   
   fdpcm=dpcm(fdc,1);
else
   fdpcm=Fq(1,1);
end
dccof=[];
for i=1:mb*nb,
   dccof=[dccof jdcenc(fdpcm(i))];
end

%pause
%echo on

% Zig-Zag scanning of AC coefficients
z=[1   2   6   7  15  16  28  29
   3   5   8  14  17  27  30  43
   4   9  13  18  26  31  42  44
  10  12  19  25  32  41  45  54
  11  20  24  33  40  46  53  55
  21  23  34  39  47  52  56  61
  22  35  38  48  51  57  60  62
  36  37  49  50  58  59  63  64];
%pause
%echo off
acseq=[];
for i=1:mb
  for j=1:nb
    tmp(z)=Fq(8*(i-1)+1:8*i,8*(j-1)+1:8*j); 
    % tmp is 1 by 64
    eobi=max(find(tmp~=0)); %end of block index
                    % eob is labelled with 999    
    acseq=[acseq tmp(2:eobi) 999];
  end
end
accof=jacenc(acseq);

disp(['DC coefficient after Huffman coding has ' int2str(length(dccof)) ...
' bits']);
disp(['AC coefficient after Huffman coding has ' int2str(length(accof)) ...
' bits']);
Com_Rate=(length(dccof)+length(accof))/(mb*nb*64);
Com_Ratio=8/((length(dccof)+length(accof))/(mb*nb*64));

disp(['Compression Rate   ' num2str(Com_Rate) '   Bits / pixel '])
disp(['Compression Ratio   ' num2str(Com_Ratio) ' : 1'])
%end