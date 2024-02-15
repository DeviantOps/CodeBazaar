function PowerSpectrum($data, $sampleRate) {

    $fft = [MathNet.Numerics.IntegralTransforms.Fourier]::Forward($data)

    $fftReal = [MathNet.Numerics.LinearAlgebra.Vector]::Build::Dense($fft.Length)

    for ($i = 0; $i -lt $fft.Length; $i++) {

        $fftReal[$i] = [Math]::Pow([Math]::Abs($fft[$i]), 2)

    }

    $freq = [MathNet.Numerics.IntegralTransforms.Fourier]::FrequencyScale($fft.Length, $sampleRate)

    $output = New-Object System.Collections.Generic.Dictionary[System.Double, System.Double]

    for ($i = 0; $i -lt $fftReal.Length / 2; $i++) {

        $output[$freq[$i]] = $fftReal[$i]

    }

    return $output

}
