function p = fsk_params()
%FSK_PARAMS  Central configuration for the acoustic FSK link.
%   Tones are chosen so each symbol holds a whole number of cycles
%   (orthogonal FSK): 2000 Hz -> 20 cycles, 3000 Hz -> 30 cycles per 10 ms.
    p.fs   = 44100;              % sample rate (Hz)
    p.f0   = 2000;               % tone for bit 0 (Hz)
    p.f1   = 3000;               % tone for bit 1 (Hz)
    p.baud = 100;                % symbols per second (1 bit per symbol)
    p.N    = round(p.fs / p.baud);   % samples per symbol
    % Linear chirp preamble used for frame synchronisation
    T  = 0.15;                   % chirp duration (s)
    t  = (0:round(T*p.fs)-1)' / p.fs;
    f_start = 1000;  f_end = 4000;
    p.preamble = sin(2*pi*(f_start*t + (f_end - f_start)/(2*T) * t.^2));
end
