def get_int(fft, freq_start, freq_end, res=100):
    out = 0.
    for i in range(freq_start, freq_end):
        out += fft.getBand(i)
    out = out/(freq_end-freq_start)
    return out

def linearA(fft):
    for i in range(fft.specSize()):
        line(i, height, i, height - fft.getBand(i)*8)

def circleA(fft, t):
    theta_0 = t/64
    freq_max = int(fft.specSize()/3)
    size_max = fft.specSize()-freq_max
    for i in range(0,size_max):
        theta = theta_0 + PI/size_max*i
        print(fft.getBand(i))
        r = 200+fft.getBand(i)*8
        x, y = cos(theta)*r,sin(theta)*r
        point(x + width/2, y + height/2)
        x, y = cos(theta)*r,-sin(theta)*r
        point(x + width/2, y + height/2)

def circleB(fft, t):
    separ = 10
    theta_0 = 0
    freq_max = int(fft.specSize()/3)
    size_max = fft.specSize()-freq_max
    numb_theta = 10
    for i in range(separ+1):
        freq_min = size_max/separ*i
        freq_max = size_max/separ*(i+1)
        val = get_int(fft, freq_min, freq_max)
        
        thetaA = PI/separ*i
        thetaB = PI/separ*(i+1)
        for j in range(numb_theta):
            theta = (thetaB-thetaA)/numb_theta*j+thetaA
            r = 200+val*15
            x, y = cos(theta)*r,sin(theta)*r
            point(x + width/2, y + height/2)
            x, y = cos(theta)*r,-sin(theta)*r
            point(x + width/2, y + height/2)
            
def circleC(fft, t, cur_val):
    separ = 10
    theta_0 = 0
    if cur_val == []:
        cur_val = [0]*separ
    freq_max = int(fft.specSize()/3)
    size_max = fft.specSize()-freq_max
    numb_theta = 10
    for i in range(separ):
        freq_min = size_max/separ*i
        freq_max = size_max/separ*(i+1)
        temp_val = get_int(fft, freq_min, freq_max)
        if temp_val > cur_val[i]:
            cur_val[i] = temp_val
        else:
            cur_val[i] = lerp(cur_val[i], temp_val, 0.1)
        
        val = cur_val[i]
        
        thetaA = PI/separ*i
        thetaB = PI/separ*(i+1)
        for j in range(numb_theta):
            theta = (thetaB-thetaA)/numb_theta*j+thetaA
            r = 200+val*15
            x, y = cos(theta)*r,sin(theta)*r
            point(x + width/2, y + height/2)
            x, y = cos(theta)*r,-sin(theta)*r
            point(x + width/2, y + height/2)
    return cur_val

def circleD(fft, t, cur_val, speed):
    separ = 10
    theta_0 = 0
    if cur_val == []:
        cur_val = [0]*separ
    freq_max = int(fft.specSize()/3)
    size_max = fft.specSize()-freq_max
    numb_theta = 10
    for i in range(separ):
        stroke(255, 200)
        strokeWeight(separ-i)
        freq_min = size_max/separ*i
        freq_max = size_max/separ*(i+1)
        temp_val = get_int(fft, freq_min, freq_max)
        if temp_val > cur_val[i]:
            cur_val[i] = temp_val
        else:
            cur_val[i] = lerp(cur_val[i], temp_val, 0.1)
        val = cur_val[i]
        r = 150 + i*37 + val*10
        
        numb_portions = i+2
        for k in range(numb_portions):
            unit = TWO_PI/numb_portions
            middle = theta_0 + noise_sign(i)*(1+noise(i))*PI*t/int(300.*(speed)) + unit*k
            thetaA = middle-unit/4
            thetaB = middle + unit/4
            
            for j in range(numb_theta):
                theta = (thetaB-thetaA)/numb_theta*j+thetaA
                theta2 = (thetaB-thetaA)/numb_theta*(j+1)+thetaA
                x, y = cos(theta)*r,sin(theta)*r
                x1, y1 = cos(theta2)*r,sin(theta2)*r
                #point(x + width/2, y + height/2)
                line(x + width/2,y+ height/2,x1 + width/2,y1+ height/2)
                
    return cur_val

def noise_sign(val):
    if noise(val) > 0.5:
        return 1
    else:
        return -1
