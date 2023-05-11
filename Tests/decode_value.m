function [ decodeValorDc ] = decode_value( codeDc, codeLength, adBits )

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% EXPLICACIONS:
% En aquesta funció...
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

    if (adBits == 0)
        decodeValorDc = 0;
    else
        if(codeDc(codeLength+1)=='0')
           for i=codeLength+1:length(codeDc)
                    if(codeDc(i)=='1')
                        codeDc(i)='0';
                    else
                        codeDc(i)='1';
                    end
           end
           decodeValorDc = -bin2dec(codeDc(codeLength+1:codeLength+adBits));
        else
           decodeValorDc = bin2dec(codeDc(codeLength+1:codeLength+adBits));
        end

    end

end