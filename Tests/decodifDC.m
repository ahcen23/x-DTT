function [valorDc numBits] = decodifDC(codeDc)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% A aquesta funció li entra la codificació de la categoria del valor 'dif'
% i el propi valor 'dif'. El que fem és el següent:

        % 1. Decodifiquem la categoria del nostre 'dif'.
        
        % 2. Decodifiquem el valor 'dif' gràcies als coneixements que hem
        % obtingut decodificant la categoria (adBits i codeLength). En cas
        % que el primer bit de la codificació del valor sigui zero, el
        % nostre 'dif' serà negatiu.
        
        
        
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% 1. DECODIFIQUEM LA CATEGORIA I OBTENIM ELS VALORS codeLength i adBits:
%--------------------------------------------------------------------------

        [decodeCatDc adBits codeLength] = decode_category_DC(codeDc);


% 2. DECODIFIQUEM EL VALOR 'DIF' GRÀCIES ALS VALORS OBTINGUTS A DALT:
%--------------------------------------------------------------------------
        [decodeValorDc] = decode_value(codeDc, codeLength, adBits);
    
        valorDc = decodeValorDc;
        catDc = decodeCatDc;
        numBits = codeLength + adBits;
    
end

