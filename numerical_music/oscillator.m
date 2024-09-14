function x = oscillator(freq, fs, dur, A, D, S, R)

  t = (0:round(dur * fs) - 1) / fs; % time vector;
  x = sin(2 * pi * freq * t); %sine wave

  nr_total_samples = round(dur * fs);

  samples_A = floor(A * fs);
  samples_D = floor(D * fs);
  samples_R = floor(R * fs);
  samples_S = nr_total_samples - samples_A - samples_D - samples_R;

  env_A = linspace(0, 1, samples_A);
  env_D = linspace(1, S, samples_D);
  env_S = linspace(S, S, samples_S);
  env_R = linspace(S, 0, samples_R);

  env = [env_A env_D env_S env_R];

  if length(env) > nr_total_samples
    env = env(1:nr_total_samples);
  elseif length(env) < nr_total_samples
    env = [env zeros(1, nr_total_samples - length(env))];
  endif

  x = x .* env;
  x = x(:); %vector coloana
endfunction

