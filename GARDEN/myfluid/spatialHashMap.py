def clamp(mi,va,ma):
    return min(ma,max(mi,va))

class SpatialHashMap():
    
    def __init__(self, width, height):
        self.width = width
        self.height = height
        self.grid = [[] for i in range(width*height)]
    
    def clear(self):
        self.grid = [[] for i in range(self.width*self.height)]
    
    def add(self,x,y,data):
        x = clamp(round(x),0,self.width-1)
        y = clamp(round(y),0,self.height-1)
        
        index = int(x+y*self.width)
        self.grid[index] += [data]
    
    def query(self,x,y,radius=None):
        if radius:
            return self.queryWithRadius(x,y,radius)
        else:
            x = clamp(round(x),0,self.width-1)
            y = clamp(round(y),0,self.height-1)
            
            index = int(x+y*self.width)
            return self.grid[index]
    
    def queryWithRadius(self,x,y,radius):
        
        left = int(max(round(x - radius), 0))
        right = int(min(round(x + radius), self.width - 1))
        bottom = int(max(round(y - radius), 0))
        top = int(min(round(y + radius), self.height - 1))
        
        result = []
        
        for i in range(left, right+1):
            for j in range(bottom, top+1):
                query = self.query(i,j)
                for k in range(len(query)):
                    result += [query[k]]
        
        return result
        
