def circleA():
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
