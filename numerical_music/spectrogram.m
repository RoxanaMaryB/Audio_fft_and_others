function [S f t] = spectrogram(signal, fs, window_size)
  sig_size = length(signal);
  nr_windows = floor(sig_size / window_size);
  S = zeros(window_size, nr_windows); % initialize
  f = zeros(window_size, 1);
  t = zeros(nr_windows, 1);

  for i = 1:window_size
    f(i) = (i-1) * (fs / (2 * window_size)); % frequency vector
  endfor

  for i = 1:nr_windows
    t(i) = (i - 1) * (window_size / fs); % time vector
  endfor

  for i = 1:nr_windows
    start = (i-1) * window_size + 1;
    stop = start + window_size - 1;

    get_window = signal(start:stop);

    hann_window = hanning(window_size); % Hanning window

    for j = 1:window_size
      wd_hann(j) = get_window(j) * hann_window(j);
    end

    wd_fft = fft(wd_hann, window_size * 2); % Fourier transform
    wd_fft = wd_fft(1:window_size);
    
    for j = 1:window_size
      S(j, i) = abs(wd_fft(j));
    end

  endfor
endfunction

