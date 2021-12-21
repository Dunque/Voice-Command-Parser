
import speech_recognition as sr

def main():

    # obtain audio from the microphone
    r = sr.Recognizer()
    r.energy_threshold = 700
    r.dynamic_energy_threshold = True
    with sr.Microphone() as source:
        print("Say something!")
        audio = r.listen(source)

    # recognize speech using Google Speech Recognition
    try:
        f = open("input", "a")
        f.write(r.recognize_google(audio))
        f.close()
        print("Google Speech Recognition thinks you said " + r.recognize_google(audio))
    except sr.UnknownValueError:
        print("Google Speech Recognition could not understand audio")
    except sr.RequestError as e:
        print("Could not request results from Google Speech Recognition service; {0}".format(e))

if __name__ =='__main__':
    main()