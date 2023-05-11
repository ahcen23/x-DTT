function [ category adBits codeLength ] = decode_category_DC( code )

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% En aquesta funció, agafem un codi, i anem mirant de manera ordenada i
% progressiva bit a bit fins que som capaços de determinar quina categoria
% és, quan bits adicionals tenim, i per tant la llargada de codi d'aquell
% 'símbol'. Tot això ho podem fer gràcies a que el codi és Huffmann i per
% tant unívoc.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    if (code(1)=='0')
        if(code(2)=='0')
            category = 0;
            adBits = 0;
            codeLength = 2;
        else
            if (code(3)=='0')
                category = 1;
                adBits = 1;
                codeLength = 3;
            else
                category = 2;
                adBits = 2;
                codeLength = 3;
            end;
        end;
    else %code(1)==1
        if(code(2)=='0')
            if (code(3)=='0');
                category = 3;
                adBits = 3;
                codeLength = 3;
            else
                category = 4;
                adBits = 4;
                codeLength = 3;
            end;
        else %code(2)==1
            if(code(3)=='0')
                category = 5;
                adBits = 5;
                codeLength = 3;
            else %code(3)==1
                if(code(4)=='0');
                    category = 6;
                    adBits = 6;
                    codeLength = 4;
                else %code(4)==1
                    if(code(5)=='0')
                        category = 7;
                        adBits = 7;
                        codeLength = 5;
                    else %code(5)==1
                        if(code(6)=='0')
                            category = 8;
                            adBits = 8;
                            codeLength = 6;
                        else %code(6)==1
                            if(code(7)=='0')
                                category = 9;
                                adBits = 9;
                                codeLength = 7;
                            else %code(7)==1
                                if(code(8)=='0')
                                    category = 10;
                                    adBits = 10;
                                    codeLength = 8;
                                else
                                    category = 11;
                                    adBits = 11;
                                    codeLength = 9;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;


end

