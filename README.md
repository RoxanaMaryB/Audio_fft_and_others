**Nume: Baranga Roxana Mary**
**Grupă: 311CA**
 # Tema 2 - Analiza datelor

## Task 1 - Numerical Music
* Programul ia ca input un fisier audio si returneaza un grafic cu spectrul audio
* Se folosesc 5 functii:
    ### stereo_to_mono.m
    - ia o matrice si calculeaza media aritmetica a elementelor de pe fiecare linie, apoi normeaza vectorul rezultat
    ```matlab
    function mono = stereo_to_mono(stereo)
    ```
    ### spectogram.m
    - calculeaza spectograma unui semnal audio (semnal) cu frecventa de esantionare fs si dimensionarea ferestrei window_size
    - imparte semnalul in ferestre de dimensiune window_size
    - semnalului din fiecare fereastra ii este aplicata functia hanning
    - calculeaza transformata Fourier a fiecarei ferestre
    - f este vectorul de frecvente, se calculeaza pt indexul i: de i-1 ori frecventa de esantionare / 2 * window_size => se distribuie uniform (conform teoremei Nyquist-Shannon)
    - t este vectorul de timp, se calculeaza pt indexul i: de i-1 ori window_size / fs
    ```matlab
    function [S f t] = spectrogram(signal, fs, window_size)
    ```

    ### oscilator.m
    - genereaza un semnal sinusoidal cu frecventa freq, durata t si forma ADSR
    - face un vector de timp t de la 0 la dur cu pasul 1/fs
    - face o functie sinusoidala cu frecventa freq
    - calculeaza forma ADSR si o pune in env
    - truncheaza env
    - aplica ADSR semnalului sinusoidal
    - transpune semnalul final
    ```matlab
    function x = oscillator(freq, fs, dur, A, D, S, R)
    ```

    ### low_pass.m
    - calculeaza transformarea Fourier rapida
    - formeaza o masca: 1 pentru frecventele sub cutoff si 0 pentru cele peste
    - aplica masca pe spectrul semnalului
    - calculeaza inversa transformarii Fourier ca sa obtina semnalul filtrat
    - normeaza semnalul filtrat
    ```matlab
    function signal = low_pass(signal, fs, cutoff_freq)
    ```

    ### apply_reverb.m
    - transforma impulse_response din stereo in mono
    - calculeaza convolutia dintre semnal si impulse_response mono
    - normeaza semnalul rezultat
    ```matlab
    function signal = apply_reverb(signal, impulse_response)
    ```

* Comentarii spectograme:
    ### Plain Loop vs Plain Sound
    <img src="./pictures/JFigure1_Plain_Loop.jpg" width="300">
    <img src="./pictures/JFigure2_Plain_Sound.jpg" width="300">

    - Timp: Plain Loop - 2s, Plain Sound - 5s
    - Frecventa: Aceeasi - de la 0 la 20000 Hz
    - Intensitate: Plain Loop - Culorile sunt distribuite relativ uniform. Desi sunt concentrate sub 5000 Hz, se observa si la frecvente mai mari, sugerand semnale continue. Plain Sound - Culorile sunt distribuite vertical, se observa formatul (kick, _hihat, _kick, _hihat, _) si se afla sub 5000 Hz.

    ### Low Pass Sound
    <img src="./pictures/JFigure3_Low_Pass_Sound.jpg" width="300">

    - Dupa filtrare, se observa ca semnalul este mai putin intens, iar frecventele inalte sunt eliminate, pastrandu-se doar cele joase. Acest fapt se observa si in fisierul audio sig2_lowpass.wav, nu se mai aude sunetul _hihat. Acest lucru se realizeaza aplicand transformarea Fourier rapida, formand o masca si aplicand-o pe spectrul semnalului, apoi calculand inversa transformarii Fourier.

    ### Reverb Sound
    <img src="./pictures/JFigure4_Reverb_Sound.jpg" width="300">

    - Dupa aplicarea reverberatiei, se observa ca semnalul este mai intens si se aude ca si cum ar fi in spatiu. Acest lucru se realizeaza transformand impulse_response din stereo in mono, calculand convolutia dintre semnal si impulse_response mono si normand semnalul rezultat. Timpul este extins de la 5s la 7s, iar spectograma reflecta o distributie uniforma a culorilor, pentru ca frecventele inalte se extind si se suprapun.

    ### Tech
    <img src="./pictures/JFigure5_Tech.jpg" width="300">

    - Spectograma reprezinta primele 10 secunde din fisierul tech.wav si arata similar cu cea de la Plain Loop, dar cu mai multe detalii si sunet de fundal.

    ### Low Pass Tech
    <img src="./pictures/JFigure6_Low_Pass_Tech.jpg" width="300">

    - Dupa aplicarea functiei low_pass, se observa ca semnalul este mai putin intens, iar sunetele inalte au fost diminuate, aduse la o frecventa foarte joasa (de la 15000 Hz la sub 2000 Hz).

    ### Reverb Tech
    <img src="./pictures/JFigure7_Reverb_Tech.jpg" width="300">

    - Dupa aplicarea functiei apply_reverb, se observa ca semnalul este mai intens si se aude ca si cum ar fi in spatiu. Se observa si pe spectograma decalarea culorilor spre dreapta, ceea ce sugereaza ca sunetul este mai lung si mai puternic si dublarea numarului de spike-uri.

    ### Low Pass Reverb Tech vs Reverb Low Pass Tech
    <img src="./pictures/JFigure8_Low_Pass_Reverb_Tech.jpg" width="300">
    <img src="./pictures/JFigure9_Reverb_Low_Pass_Tech.jpg" width="300">

    - Cele doua spectograme sunt asemanatoare, dar se observa ca in Low Pass Reverb Tech au fost diminuate frecventele inalte, apoi a fost aplicata reverberatia. Asta a determinat ca toate frecventele sa fie foarte joase. Se observa si extinderea de la 10 la 12 secunde datorata reverberatiei peste care nu a fost aplicat low pass, determinand aparitia unui spike la aproape 20000 Hz dupa a 10-a secunda.
    - In Reverb Low Pass Tech au fost eliminate frecventele inalte dupa reverb, dar s-au pastrat sunetele joase si medii extinse. De asemenea, extinderea de la 10 la 12 secunde este mai putin pronuntata.

## Task 2 - Robotzii
* Programul ia ca input un fisier csv cu date si calculeaza traiectoria robotului
* Se folosesc 5 functii:
    ### parse_data.m
    - citeste datele din fisierul csv (n - numarul de coordonate, n coordonate x si n coordonate y - abscisele si ordonatele punctelor)
    ```matlab
    function [x, y] = parse_data(filename)
    ```
    ### spline_c2.m
    - calculeaza coeficientii spline-ului c2 de interpolare
    - se seteaza in primul rand valorile la capetele intervalului
    - se egaleaza valorile in punctele de intersectie
    - se egaleaza derivata 1 in punctele de intersectie
    - se egaleaza derivata 2 in punctele de intersectie
    - se seteaza derivata a doua la capete la 0
    - se rezolva sistemul de ecuatii
    ```matlab
    function coef = spline_c2 (x, y)
    ```

    ### P_spline.m
    - calculeaza valoarea spline-ului in punctele din x_interp
    - parcurge fiecare punct din x_interp
    - calculeaza coeficientii
    - calculeaza valoarea polinomului => y_interp
    ```matlab
    function y_interp = P_spline (coef, x, x_interp)
    ```

    ### vandermonde.m
    - calculeaza coeficientii polinomului Vandermonde
    - initializeaza matricea A cu 0
    - introduce pe fiecare coloana i x la puterea i-1
    - rezolva sistemul => coeficientii
    ```matlab
    function coef = vandermonde(x, y)
    ```

    ### P_vandermonde.m
    - calculeaza valoarea polinomului Vandermonde in punctele din x_interp
    - parcurge fiecare punct din x_interp
    - calculeaza coeficientii
    - calculeaza valoarea polinomului => y_interp
    ```matlab
    function y_interp = P_vandermonde (coef, x_interp)
    ```
## Task 3 - Recommendations
* Programul ia ca input o matrice de rating-uri, unde fiecare linie reprezinta un client, fiecare coloana reprezinta o tema, iar fiecare element al matricei reprezinta rating-ul dat de user pentru item.
* Se folosesc 4 functii:
    ### read_mat.m
    - parseaza fisierul csv cu functia csvread si ignora headerele de pe prima linie si prima coloana
    ```matlab
    function mat = read_mat(path)
    ```
    ### preprocess.m
    - elimina clientii care au dat rating la mai putin de min_count teme
    - se foloseste de vectorul rows pentru a retine indicii clientilor care au dat rating la cel putin min_count teme
    ```matlab
    function reduced_mat = preprocess(mat, min_reviews)
    ```
    ### cosine_similarity.m
    - calculeaza similaritatea cosinus intre 2 vectori
    - ia ca input 2 vectori A B, ii normalizeaza si aplica formula de similaritate cosinus
    ```matlab
    function similarity = cosine_similarity(A, B)
    ```
    ### recommendations.m
    - returneaza indicele temelor recomandate pentru un client
    - apeleaza read_mat si preprocess pentru a citi datele si a le prelucra
    - descompune matricea preprocesata in U S V
    - pentru fiecare client, calculeaza similaritatea cu ceilalti clienti si sorteaza rating-urile temelor in functie de similaritate
    - returneaza indicele temelor cu rating-ul cel mai mare
    ```matlab
    function recoms = recommendations(path, liked_theme, num_recoms, min_reviews, num_features)
    ```
