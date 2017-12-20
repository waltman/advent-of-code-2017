import re

class Particle:
    def __init__(self, line):
        tok = line.split(', ')
        self.px, self.py, self.pz = self._parse(tok[0])
        self.vx, self.vy, self.vz = self._parse(tok[1])
        self.ax, self.ay, self.az = self._parse(tok[2])
        self.hit = False

    def _parse(self, tok):
        tok = re.sub('[^\d\-,]', '', tok)
        return [int(x) for x in tok.split(',')]

    def dump(self):
        return "p=({},{},{}), v=({},{},{}), a=({},{},{})".format(self.px, self.py, self.pz,
                                                                 self.vx, self.vy, self.vz,
                                                                 self.ax, self.ay, self.az)

    def tick(self):
        self.vx += self.ax
        self.vy += self.ay
        self.vz += self.az

        self.px += self.vx
        self.py += self.vy
        self.pz += self.vz

    def accel_mag(self):
        return abs(self.ax) + abs(self.ay) + abs(self.az)

    def collision(self, p):
        return self.px == p.px and self.py == p.py and self.pz == p.pz

    def set_hit(self):
        self.hit = True

    def unhit(self):
        return not self.hit
    
