function [valorAc numZeros numBits EndOfBlock] = decodifAC(code)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% A aquesta funció ens decodifica els valors AC
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% 1. DECODIFIQUEM LA CATEGORIA I OBTENIM ELS VALORS codeLength i adBits:
%--------------------------------------------------------------------------

    [runsize codeLength_AC] = decode_category_AC(code);
    
    if (strcmp(runsize,'00'))
        EndOfBlock = boolean (1);
        valorAc = 0;
        numBits = 4;
        numZeros = 0;
    else
        EndOfBlock = boolean (0);
        category = (hex2dec(runsize(2)));
        numZeros = hex2dec(runsize(1));

        adBits = category;

        % 2. DECODIFIQUEM EL VALOR 'DIF' GRÀCIES ALS VALORS OBTINGUTS A DALT:
        %--------------------------------------------------------------------------
        [decodeValorAc] = decode_value(code, codeLength_AC, adBits);

        valorAc = decodeValorAc;
        numBits = codeLength_AC + adBits;
    end
end
