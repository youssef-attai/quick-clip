class Text:
    def __init__(self, title, content):
        self.title = title
        self.content = content

    def to_tuple(self):
        return self.title, self.content

    @classmethod
    def from_tuple(cls, t: tuple):
        return Text(t[0], t[1])
