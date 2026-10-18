function bits = text_to_bits(txt)
%TEXT_TO_BITS  Frame a string as bits: [8-bit length][8 bits per character].
    if numel(txt) > 255
        error('Message too long (max 255 characters).');
    end
    header  = dec2bin(numel(txt), 8) - '0';
    payload = dec2bin(double(txt), 8) - '0';
    bits = [header(:); reshape(payload', [], 1)];
end
