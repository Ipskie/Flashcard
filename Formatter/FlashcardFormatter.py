import xml.etree.ElementTree as ET
import regex as re

def fileContents(name: str) -> str:
    f = open(name,"r")
    return f.read()



if __name__ == "__main__":
    tree = ET.parse('file.xml')
    root = tree.getroot()