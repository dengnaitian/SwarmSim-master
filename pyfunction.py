
def search(words):

    newlist = [w for w in words if 'son' in w]
    return newlist

def theend(words):
    words.append('The End')
    return words