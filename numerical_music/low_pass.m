function signal = low_pass(signal, fs, cutoff_freq)
    X = fft(signal); % Fourier transform
    N = length(signal);
    f = (0:N-1) * fs / N;
    mask = f <= cutoff_freq; % filter
    X_filtered = X .* mask';
    signal = ifft(X_filtered); % inverse Fourier transform
    signal = signal / max(abs(signal)); % normalize
endfunction

