% Smart Sensor Interface Simulation in MATLAB

%% Step 1: Simulate Time and "True" Sensor Data
fs = 100;                    % Sampling frequency (Hz)
t = 0:1/fs:10;               % Time vector for 10 seconds
true_signal = 25 + 2*sin(2*pi*0.1*t);  % Simulated temperature variation (°C)

%% Step 2: Add Noise to Simulate Real-World Sensor Data
noise = 0.5 * randn(size(t));           % Gaussian noise
noisy_signal = true_signal + noise;     % Noisy sensor signal

%% Step 3: Apply Filtering Techniques

% 3.1 Moving Average Filter
windowSize = 10;                        % Window size (samples)
moving_avg_filtered = movmean(noisy_signal, windowSize);

% 3.2 Butterworth Low-Pass Filter
order = 2;                              % Filter order
cutoff_freq = 0.2;                      % Normalized cutoff frequency (0 to 1)
[b, a] = butter(order, cutoff_freq, 'low'); % Design filter
butter_filtered = filtfilt(b, a, noisy_signal); % Zero-phase filtering

%% Step 4: Plot the Results
figure('Color', 'w');
plot(t, noisy_signal, 'r--', 'DisplayName', 'Noisy Signal'); hold on;
plot(t, moving_avg_filtered, 'b', 'LineWidth', 1.5, 'DisplayName', 'Moving Average Filter');
plot(t, butter_filtered, 'g', 'LineWidth', 1.5, 'DisplayName', 'Butterworth Filter');
plot(t, true_signal, 'k', 'LineWidth', 1.2, 'DisplayName', 'True Signal');

title('Smart Sensor Interface – Signal Filtering', 'FontSize', 14);
xlabel('Time (s)');
ylabel('Sensor Output (°C)');
legend('Location', 'best');
grid on;

%% Export Filtered Data to CSV

data = table(t', noisy_signal', moving_avg_filtered', butter_filtered', true_signal',...
     'VariableNames', {'Time_s', 'Noisy', 'MovingAvg', 'Butterworth', 'TrueSignal'});
 writetable(data, 'sensor_data_filtered.csv');

