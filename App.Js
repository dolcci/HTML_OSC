let audioCTX = new AudioContext();
let dac = audioCTX.destination;
let buff = null;
let src = audioCTX.createBufferSource();
src.start();
let isPlaying = false;
let previousId;

function loadAudio(id)
{
    let request = new XMLHttpRequest();
    request.open("GET", './audio/Lenna' + id + '.wav', true);
    request.responseType = "arraybuffer";
    request.onload = function()
    {
        audioCTX.decodeAudioData(request.response, function (data) {
            src.stop();
            buff = data;
            playAudio();
        });
    };
    request.send();
    initWaveSurfer(id);
    setStyle(id);

}

function playAudio()
{
        src = audioCTX.createBufferSource();
        src.buffer = buff;
        src.connect(dac);
        src.start();
        isPlaying = true;
}

function stopAudio()
{
    src.stop();
    setStyle();
}

function initWaveSurfer(id)
{
    document.getElementById('waveform').innerHTML = "";
    let wavesurfer = WaveSurfer.create(
        {
            container: '#waveform',
            waveColor: '#ECEFF1',
            progressColor: '#ECEFF1',
            cursorWidth: 0,
            interact: false
        }
    )
    wavesurfer.load('./audio/Lenna' + id + '.wav');
}

function setStyle(id)
{
    if(previousId)
    {
        document.getElementById(previousId).className = 'button';
    }
    if(id)
    {
        document.getElementById(id).className = 'buttonSelected';
        previousId = id;
    }
}
