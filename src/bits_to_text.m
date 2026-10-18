function txt = bits_to_text(bits)
%BITS_TO_TEXT  Inverse of TEXT_TO_BITS. Returns '' if the frame is incomplete.
    bits = bits(:);
    if numel(bits) < 8,  txt = '';  return;  end
    len = bin2dec(char(bits(1:8)' + '0'));
    need = 8 + 8*len;
    if numel(bits) < need,  txt = '';  return;  end
    if len == 0,  txt = '';  return;  end
    chars = reshape(bits(9:need), 8, [])';
    txt = char(bin2dec(char(chars + '0')))';
end
