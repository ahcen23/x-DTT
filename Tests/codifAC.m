function [codeAc] = codifAC(seqCoef)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% A aquesta funció li entra la cadena de valors analitzats en zig zag del
% run length coding del bloc actual i el que fem és codificar-lo amb els
% següents passos:
    
        % 1. Compto quants zeros hi ha fins al pròxim coeficient

        % 2. Trobem la categoria del coeficient
        
        % 3. Codifiquem la categoria del coeficient
        
        % 4. Codifiquem el valor (invertint bits en cas negatiu)
        
        % 5. Concatenem el nombre de zeros amb la codificació de la
        % categoria i amb la codificació del valor del coeficient (bits
        % adicionals) 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

codeAc = char.empty;
    % 1. Compto quants zeros hi ha fins al pròxim coeficient:
    numZeros = 0;
    

    for i=2:64
        if (sum(abs(seqCoef(i:end)))==0) % Si tot el que queden són zeros paro.
            codeAc = [codeAc '1010'];
            break % Faig que surti del for i pari
        else
            if(numZeros == 16) % Si porto 16 zeros codifico com '11111111001'
                codeAc = [codeAc '11111111001'];
                numZeros = 0;
            else
                if (seqCoef(i)~=0) % Si tinc un coeficient diferent de 0.
                    % 2. TROBEM LA CATEGORIA DEL COEFICIENT:
                    catAc = find_category_AC(seqCoef(i));

                    % 3. CODIFIQUEM LA CATEGORIA (SSSS):
                    cathex = dec2hex(catAc);
                    RRRR = dec2hex(numZeros);
                    runsize = [RRRR cathex];
                    
                    codeCatAc = code_category_AC(runsize);

                    % 4. CODIFIQUEM EL VALOR DEL NOSTRE coeficient:
                    codeCoefAc = code_value(seqCoef(i));

                    % 5. CONCATENEM LES DUES CODIFICACIONS:  
                    codeAc = [codeAc codeCatAc codeCoefAc];
                    numZeros = 0;
                else % Si tinc un coeficient que és 0.
                    numZeros = numZeros+1;
                end
            end
        end
    end
    
end

