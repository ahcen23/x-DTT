function [ category ] = find_category_AC( value )

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% A aquesta funció li passem un valor (value) i ens busca a quina categoria
% (de 0 a 11) pertany i ens la retorna (category).
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    if(abs(value)==1)
        category = 1;
    end
    
    if((abs(value)==2)||(abs(value)==3))
        category = 2;
    end
    
    if((4 <= abs(value))&&(abs(value) <= 7))
        category = 3;
    end
    
    if((8 <= abs(value))&&(abs(value) <= 15))
        category= 4;
    end
    
    if((16 <= abs(value))&&(abs(value) <= 31))
        category = 5;
    end
    
    if((32 <= abs(value))&&(abs(value) <= 63))
        category= 6;
    end
    
    if((64 <= abs(value))&&(abs(value) <= 127))
        category = 7;
    end
    
    if((128 <= abs(value))&&(abs(value) <= 255))
        category= 8;
    end
    
    if((256 <= abs(value))&&(abs(value) <= 511))
        category = 9;
    end
    
    if((512 <= abs(value))&&(abs(value) <= 1023))
        category= 10;
    end
    
end
