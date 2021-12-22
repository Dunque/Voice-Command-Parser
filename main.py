
import speech_recognition as sr
import sys
import os

def main():
    if (len(sys.argv) < 2 ):
        os.system("./lexerParser input")
    elif (sys.argv[1] == "-voice"):
        # obtain audio from the microphone
        r = sr.Recognizer()
        r.energy_threshold = 700
        r.dynamic_energy_threshold = True
        with sr.Microphone() as source:
            print("Say something!")
            audio = r.listen(source)

        # recognize speech using Google Speech Recognition
        try:
            f = open("input", "w")
            f.write(r.recognize_google(audio, language="es-ES"))
            f.close()
            print("El reconocedor de voz de Google cree que has dicho: " + r.recognize_google(audio, language="es-ES"))
            os.system("./lexerParser input")
        except sr.UnknownValueError:
            print("Google Speech Recognition could not understand audio")
        except sr.RequestError as e:
            print("Could not request results from Google Speech Recognition service; {0}".format(e))

    elif (sys.argv[1] == "-text"):
        f = open("input", "w")
        f.write(input())
        f.close()
        os.system("./lexerParser input")

    elif ():
        print("Parámetro incorrecto, utiliza -voice o -text")

if __name__ =='__main__':
    main()