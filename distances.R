dyn.load("method/distances.so")
.C("minkoski_distance", x = as.double(c(1,2,3)), 
                        y = as.double(c(1,2,3)), 
                        n = as.integer(3), 
                        r = as.integer(2), 
                        result = 0)
