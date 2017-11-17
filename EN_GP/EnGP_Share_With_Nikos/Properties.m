classdef Properties
    %PROPERTIES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pop_size = 20;
        optimiser = 'QPSO';
        lims = [];
        parallel = false;
        gpu = false;
        plot_type = 'ss';
        normalise = true;
    end
    
    methods
        function self = Properties()
            
        end
    end
    
end

