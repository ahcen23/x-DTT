function [codeDc] = codifDC(dif)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% A aquesta funció li entra el valor dif (és a dir, la resta entre el Dc
% del bloc actual i el Dc del bloc anterior) i el que fem és codificar-lo
% amb els següents passos:

        % 1. Trobem la categoria del nostre valor 'dif'
        
        % 2. Codifiquem la categoria dle nostre valor 'dif'
        
        % 3. Codifiquem el valor 'dif' (invertint bits en cas negatiu)
        
        % 4. Concatenem la codificació de la categoria amb la codificació
        % del nostre valor 'dif'.   
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    % 1. TROBEM LA CATEGORIA DEL VALOR dif:
    catDif = find_category_DC(dif); 
    
    % 2. CODIFIQUEM LA CATEGORIA DEL NOSTRE VALOR dif:
    codeCatDif = code_category_DC(catDif);
    
    % 3. CODIFIQUEM EL VALOR DEL NOSTRE dif:
    codeDif = code_value(dif);
    
    if (dif~=0)
        % 4. CONCATENEM LES DUES CODIFICACIONS:  
        codeDc = [codeCatDif codeDif];
    else
        codeDc = [codeCatDif];
    end
    

end