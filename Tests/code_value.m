function [ code ] = code_value( value )

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% A aquesta funció li passem un valor (value) i el codifica. Primer el
% passa a binari i després, si el valor que codifiquem és negatiu (més
% petit que zero) invertim els bits (és a dir els 1 passen a ser 0 i vice
% versa.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    code = dec2bin(abs(value));   
    
    if(value<0)
        for i=1:length(code)
            if(code(i)=='1')
                code(i)='0';
            else
                code(i)='1';
            end
        end
    end
    
end

