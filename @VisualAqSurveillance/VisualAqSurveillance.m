 classdef (Sealed = true) VisualAqSurveillance < Block
% Copyright 2008 - 2021, MIT Lincoln Laboratory
% SPDX-License-Identifier: X11
%
% VisualAqSurveillance

    properties
        surveillanceSampletime_s = 0.1; % Sensor sample time, in seconds

        %AREA_S the surface area of aircraft array for Mod 3
        area_s=[1,1,1;2,2,2;3,3,3];
        
        %T2 - time of evaluation for mod 5
        t2=0;
        
        %T1 D1 - time of alert and distance of alerting if using alerting
        %currently supressed for mod 6
        d1=0;
        t1=0;
        
        %pilot presence, effort, and cockpit seat location for mod 4
        pr=0;  %Right pilot present 1=normal search, 0 = no pilot, 0.5 = halfhearted search
        pl=1;  %Left pilot present 1=normal search, 0 = no pilot, 0.5 = halfhearted search
        
        %variables for the pilots field of view for mod 4
        fovl=-110;    %field of view left
        fovr=90;    %field of view right
        fovu=35;    %field of view up
        fovd=-20;    %field of view down
        
        %variables for the rate of aquisition for mod 4
        beta0=17000; %rate for aquisition - no alert
        beta1=14000; %rate of aquisition for alerted search TCAS
        
        % constants needed for module 7 
        alert=0; %flag for using alerting or not
        r=20;    %visual range
        dlim=1;  %resolution of eye to determine targets 
        vis=1;   %visibility air/fog/haze
        vdf=1;   %visual degredation factor - dirty winshield etc.
        
        rseed= 0.1; %beteen 0 and 1
        
    end
    
    
    
    methods
        function obj = VisualAqSurveillance (tunableParameterPrefix,varargin)
            if( nargin < 1 )
                    tunableParameterPrefix = '';
            end
                
            p = inputParser;
            % Required parameters
            addRequired(p,'tunableParameterPrefix',@ischar);
            addParameter(p,'surveillanceSampletime_s',obj.surveillanceSampletime_s,@isnumeric);
            
            addParameter(p,'area_s',obj.area_s,@isnumeric);
            
            addParameter(p,'t2',obj.t2,@isnumeric);
            
            addParameter(p,'d1',obj.d1,@isnumeric);
            addParameter(p,'t1',obj.t1,@isnumeric);
            
            addParameter(p,'pl',obj.pl,@isnumeric);
            addParameter(p,'pr',obj.pr,@isnumeric);
            
            addParameter(p,'fovl',obj.fovl,@isnumeric);
            addParameter(p,'fovr',obj.fovr,@isnumeric);
            addParameter(p,'fovu',obj.fovu,@isnumeric);
            addParameter(p,'fovd',obj.fovd,@isnumeric);
            
            addParameter(p,'beta0',obj.beta0,@isnumeric);
            addParameter(p,'beta1',obj.beta1,@isnumeric);
            
            addParameter(p,'alert',obj.alert,@isnumeric);
            addParameter(p,'r',obj.r,@isnumeric);
            addParameter(p,'dlim',obj.dlim,@isnumeric);
            addParameter(p,'vis',obj.vis,@isnumeric);
            addParameter(p,'vdf',obj.vdf,@isnumeric);
            
            parse(p,tunableParameterPrefix,varargin{:});
            
            obj.tunableParameterPrefix = p.Results.tunableParameterPrefix;      
        end % End constructor
        function set.surveillanceSampletime_s(obj,value)
            if(~isnumeric(value) || value <= 0)
                error('Invalid surveillance sample time. surveillanceSampletime_s must be a number greater than zero.');
            end
            obj.surveillanceSampletime_s = value;
        end
        function set.area_s(obj,value)
            if(~isnumeric(value) || size(value,2) ~= 3) %potentially check for degrees vert/lat?
                error('Invalid Aircraft Surface Area. area_s must be a number and have 3 columns (lateral bearing deg, vertical bearing deg, surface area ft).');
            end
            obj.area_s = value;
        end
        function set.t2(obj,value)
            if(~isnumeric(value) )
                error('Invalid Evaluation Period (seconds). t2 must be a number.');
            end
            obj.t2 = value;
        end
        function set.t1(obj,value)
            if(~isnumeric(value) )
                error('Invalid Alert Evaluation Period (seconds). t1 must be a number.');
            end
            obj.t1 = value;
        end
        function set.d1(obj,value)
            if(~isnumeric(value) )
                error('Invalid Alert Evaluation Distance (nm). d1 must be a number.');
            end
            obj.d1 = value;
        end
        function set.pl(obj,value)
            if(~isnumeric(value)  || value > 1 || value < 0)
                error('Invalid Left Pilot Search Rate. pl must be a number between 1 and 0.');
            end
            obj.pl = value;
        end
        function set.pr(obj,value)
            if(~isnumeric(value) || value > 1 || value < 0)
                error('Invalid Right Pilot Search Rate. pr must be a number between 1 and 0.');
            end
            obj.pr = value;
        end
        function set.fovl(obj,value)
            if(~isnumeric(value) )
                error('Invalid Pilot Field of View Left max range (degrees). fovl must be a number.');
            end
            obj.fovl = value;
        end
        function set.fovr(obj,value)
            if(~isnumeric(value) )
                error('Invalid Pilot Field of View Right max range (degrees). fovr must be a number.');
            end
            obj.fovr = value;
        end
        function set.fovu(obj,value)
            if(~isnumeric(value) )
                error('Invalid Pilot Field of View Up max range (degrees). fovu must be a number.');
            end
            obj.fovu = value;
        end
        function set.fovd(obj,value)
            if(~isnumeric(value) )
                error('Invalid Pilot Field of View Down max range (degrees). fovd must be a number.');
            end
            obj.fovd = value;
        end
        function set.beta0(obj,value)
            if(~isnumeric(value) || value < 0)
                error('Invalid Beta for unalerted search. beta0 must be a number greater than 0.');
            end
            obj.beta0 = value;
        end
        function set.beta1(obj,value)
            if(~isnumeric(value) || value < 0)
                error('Invalid Beta for alerted search. beta1 must be a number greater than 0.');
            end
            obj.beta1 = value;
        end
        function set.alert(obj,value)
            if(~isnumeric(value) || ~(isequal(value,1)||isequal(value,0)) )
                error('Invalid Use Alerting Flag (1=alert, 0=no alerts). alert must be either 1 or 0.');
            end
            obj.alert = value;
        end
        function set.r(obj,value)
            if(~isnumeric(value) || value < 0)
                error('Invalid Visual Range (nm). r must be a number greater or equal to 0.');
            end
            obj.r = value;
        end
        function set.dlim(obj,value)
            if(~isnumeric(value) )
                error('Invalid Resolution limit of human eye (arc-min). dlim must be a number.');
            end
            obj.dlim = value;
        end
        function set.vis(obj,value)
            if(~isnumeric(value) || value > 1 || value < 0)
                error('Invalid Visibility Factor. vis must be a number between 0 and 1.');
            end
            obj.vis = value;
        end
        function set.vdf(obj,value)
            if(~isnumeric(value) || value >1 || value <0)
                error('Invalid Visual Degredeation Factor. vdf must be a number between 0 and 1.');
            end
            obj.vdf = value;
        end
    end % End methods
end % End classef