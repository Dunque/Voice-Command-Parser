import sys
import webbrowser

if (sys.argv[1] == "Google" or sys.argv[1] == "google" or sys.argv[1] == "en google" or sys.argv[1] == "en Google"):
    url = "https://www.google.com/search?q={}".format(sys.argv[2])
    webbrowser.open_new_tab(url)
elif (sys.argv[1] == "Bing" or sys.argv[1] == "bing" or sys.argv[1] == "en Bing" or sys.argv[1] == "en bing"):
    url = "https://www.bing.com/search?q={}".format(sys.argv[2])
    webbrowser.open_new_tab(url)
elif (sys.argv[1] == "Duckduckgo" or sys.argv[1] == "duckduckgo" or sys.argv[1] == "en Duckduckgo" or sys.argv[1] == "en duckduckgo"):
    url = "https://duckduckgo.com/?q={}".format(sys.argv[2])
    webbrowser.open_new_tab(url)
