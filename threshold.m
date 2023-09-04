function y = threshold (y,T,method)

    switch method
        
        %hard threshold
        case 'hard'
        y(abs(y)<T)=0;
        
        %soft threshold
        case 'soft'
        y(abs(y)<T)=0;
        y = sign(y).*(abs(y)-T);
    
        %modified hard threshold
        case 'MH'
        u=255;
        yy=y(abs(y)<T);
        y(abs(y)<T) = T*((1/u)*(power((1+u),(yy/T))-1).*sign(yy));
        
    end
      
end