% INITSTATEMACHINEYOGA initializes the robot configuration for running
%                      'YOGA' demo. 
% 

%% --- Initialization ---

% Feet in contact (COORDINATOR DEMO ONLY)
Config.LEFT_RIGHT_FOOT_IN_CONTACT = [1 1];

% Initial foot on ground. If false, right foot is used as default contact
% frame (this does not means that the other foot cannot be in contact too).
% (COORDINATOR DEMO ONLY)
Config.LEFT_FOOT_IN_CONTACT_AT_0 = true;

% If true, the robot CoM will follow a desired reference trajectory (COORDINATOR DEMO ONLY)
Config.DEMO_MOVEMENTS = false;

% If equal to one, the desired streamed values of the center of mass 
% are smoothed internally 
Config.SMOOTH_COM_DES = true;   

% If equal to one, the desired streamed values of the postural tasks are
% smoothed internally 
Config.SMOOTH_JOINT_DES = true;   

% torque saturation
Sat.torque = 60;

%% Regularization parameters
Reg.pinvDamp_nu_b = 1e-7;
Reg.pinvDamp      = 1; 
Reg.pinvTol       = 1e-5;
Reg.impedances    = 0.1;
Reg.dampings      = 0;
Reg.HessianQP     = 1e-7;    
                            
%% COM AND JOINT GAINS 
Gain.KP_COM     =      [10    50  10  % state ==  1  TWO FEET BALANCING
                        10    50  10  % state ==  2  COM TRANSITION TO LEFT 
                        10    50  10  % state ==  3  LEFT FOOT BALANCING
                        10    50  10  % state ==  4  YOGA LEFT FOOT 
                        10    50  10  % state ==  5  PREPARING FOR SWITCHING 
                        10    50  10  % state ==  6  LOOKING FOR CONTACT
                        10    50  10  % state ==  7  TRANSITION TO INITIAL POSITION 
                        10    50  10  % state ==  8  COM TRANSITION TO RIGHT FOOT
                        10    50  10  % state ==  9  RIGHT FOOT BALANCING
                        10    50  10  % state == 10  YOGA RIGHT FOOT 
                        10    50  10  % state == 11  PREPARING FOR SWITCHING 
                        10    50  10  % state == 12  LOOKING FOR CONTACT
                        10    50  10];% state == 13  TRANSITION TO INITIAL POSITION

Gain.KD_COM = 2*sqrt(Gain.KP_COM);

Gain.KP_AngularMomentum  = 0.25 ;
Gain.KD_AngularMomentum  = 2*sqrt(Gain.KP_AngularMomentum);

%                   %   TORSO  %%      LEFT ARM   %%      RIGHT ARM   %%         LEFT LEG            %%         RIGHT LEG           %% 
Gain.impedances  = [10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  1  TWO FEET BALANCING
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  2  COM TRANSITION TO LEFT 
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  3  LEFT FOOT BALANCING
                    30   30   30, 10   10    10   10, 10   10    10   10, 50   50  250   200     50  50, 50   50   50    50     50  50  % state ==  4  YOGA LEFT FOOT 
                    30   30   30, 10   10    10   10, 10   10    10   10, 30   50  300    60     50  50, 30   50   30    60     50  50  % state ==  5  PREPARING FOR SWITCHING 
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  6  LOOKING FOR CONTACT
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  7  TRANSITION TO INITIAL POSITION 
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  8  COM TRANSITION TO RIGHT FOOT
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state ==  9  RIGHT FOOT BALANCING
                    30   30   30, 10   10    10   10, 10   10    10   10, 50   50   50    50     50  50, 50   50  250   200     50  50  % state == 10  YOGA RIGHT FOOT 
                    30   30   30, 10   10    10   10, 10   10    10   10, 30   50   30    60     50  50, 30   50  300    60     50  50  % state == 11  PREPARING FOR SWITCHING 
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50  % state == 12  LOOKING FOR CONTACT
                    10   30   20, 10   10    10    8, 10   10    10    8, 30   50   30    60     50  50, 30   50   30    60     50  50];% state == 13  TRANSITION TO INITIAL POSITION

Gain.dampings    = 0*sqrt(Gain.impedances(1,:));  

% Smoothing time gain scheduling (YOGA DEMO ONLY)
Gain.SmoothingTimeGainScheduling = 2;

%% STATE MACHINE PARMETERS

% smoothing time for joints and CoM
Sm.smoothingTimeCoM_Joints       = [5;   %% state ==  1  TWO FEET BALANCING
                                    5;   %% state ==  2  COM TRANSITION TO LEFT FOOT
                                    3;   %% state ==  3  LEFT FOOT BALANCING 
                                    4;   %% state ==  4  YOGA LEFT FOOT
                                    5;   %% state ==  5  PREPARING FOR SWITCHING
                                    5;   %% state ==  6  LOOKING FOR CONTACT 
                                    4;   %% state ==  7  TRANSITION INIT POSITION
                                    5;   %% state ==  8  COM TRANSITION TO RIGHT FOOT
                                    3;   %% state ==  9  RIGHT FOOT BALANCING 
                                    4;   %% state == 10  YOGA RIGHT FOOT
                                    5;   %% state == 11  PREPARING FOR SWITCHING
                                    5;   %% state == 12  LOOKING FOR CONTACT 
                                    4];  %% state == 13  TRANSITION INIT POSITION

% time between two yoga positions (YOGA DEMO ONLY)
Sm.joints_pauseBetweenYogaMoves = 3;

% contact forces threshold (YOGA DEMO ONLY)
Sm.wrench_thresholdContactOn  = 25;
Sm.wrench_thresholdContactOff = 85;

% threshold on CoM and joints error (YOGA DEMO ONLY)
Sm.CoM_threshold                = 0.01; 
Sm.joints_thresholdNotInContact = 5;
Sm.joints_thresholdInContact    = 50;

% initial state for state machine (YOGA DEMO ONLY)
Sm.stateAt0 = 1;

% delta to be summed to the reference CoM position (YOGA DEMO ONLY)

Sm.CoM_delta       = [% THIS REFERENCE IS USED AS A DELTA W.R.T. THE POSITION OF THE LEFT FOOT
                      0.0,  0.00, 0.0;   %% NOT USED
                      0.0,  0.01, 0.0;   %% state ==  2  COM TRANSITION TO LEFT FOOT
                      0.0,  0.00, 0.0;   %% state ==  3  LEFT FOOT BALANCING 
                      0.0,  0.01, 0.0;   %% state ==  4  YOGA LEFT FOOT
                      0.0,  0.00, 0.0;   %% state ==  5  PREPARING FOR SWITCHING
                      0.0, -0.09, 0.0;   %% state ==  6  LOOKING FOR CONTACT 
                      0.0,  0.00, 0.0;   %% NOT USED
                      % THIS REFERENCE IS USED AS A DELTA W.R.T. THE POSITION OF THE RIGHT FOOT
                      0.0, -0.01, 0.0;   %% state ==  8  COM TRANSITION TO RIGHT FOOT
                      0.0,  0.00, 0.0;   %% state ==  9  RIGHT FOOT BALANCING 
                      0.0, -0.00, 0.0;   %% state == 10  YOGA RIGHT FOOT
                      0.0, -0.00, 0.0;   %% state == 11  PREPARING FOR SWITCHING
                      0.0,  0.09, 0.0;   %% state == 12  LOOKING FOR CONTACT 
                      0.0,  0.00, 0.0];  %% NOT USED

% configuration parameters for state machine (YOGA DEMO ONLY) 
Sm.tBalancing               = 1;
Sm.tBalancingBeforeYoga     = 1;
Sm.skipYoga                 = false;
Sm.demoOnlyBalancing        = false;
Sm.demoStartsOnRightSupport = false;
Sm.yogaAlsoOnRightFoot      = false;
Sm.yogaInLoop               = false;

%% Joint references (YOGA DEMO ONLY)
Sm.joints_references = [zeros(1,ROBOT_DOF);                                %% NOT USED
                       [-0.0348,0.0779,0.0429, ...                         %% state == 2  COM TRANSITION TO LEFT 
                        -0.1493,0.8580,0.2437,0.8710, ...                  %
                        -0.1493,0.8580,0.2437,0.8710, ...                  %
                        -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630, ...  %  
                         0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151];    %  
                       [ 0.0864,0.0258,0.0152, ...                         %% state == 3  LEFT FOOT BALANCING
                         0.1253,0.8135,0.3051,0.7928, ...                  %    
                         0.0563,0.6789,0.3340,0.6214, ...                  %
                        -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630, ...  %  
                         0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151];    % 
                        zeros(1,ROBOT_DOF);                                %% NOT USED
                       [-0.0348,0.0779,0.0429, ...                         %% state == 5  PREPARING FOR SWITCHING
                        -0.1493,0.8580,0.2437,0.8710, ...                  %
                        -0.1493,0.8580,0.2437,0.8710, ...                  %
                        -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630, ...  %  
                         0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151];    %                                  
                       [ 0.0864,0.0258,0.0152, ...                         %% state == 6  LOOKING FOR CONTACT
                         0.1253,0.8135,0.3051,0.7928, ...                  %
                         0.0563,0.6789,0.3340,0.6214, ...                  %
                         0.0107,-0.0741,-0.0001,-0.0120,0.0252,0.1369,...  %
                        -0.0026,0.0225,0.0093,-0.0020,0.0027,-0.0277];     %   
                        zeros(1,ROBOT_DOF);                                %% NOT USED
                       [ 0.0864,0.0258,0.0152, ...                         %% state == 8  COM TRANSITION TO RIGHT FOOT
                         0.1253,0.8135,0.3051,0.7928, ...                  %
                         0.0563,0.6789,0.3340,0.6214, ...                  %
                         0.0107,-0.0741,-0.0001,-0.0120,0.0252,0.1369,...  %
                        -0.0026,0.0225,0.0093,-0.0020,0.0027,-0.0277];     % 
                       [ 0.0864,0.0258,0.0152, ...                         %% state == 9  RIGHT FOOT BALANCING
                         0.1253,0.8135,0.3051,0.7928, ...                  %    
                         0.0563,0.6789,0.3340,0.6214, ...                  %
                         0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151, ... %  
                        -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630];     %  
                        zeros(1,ROBOT_DOF);                                %% NOT USED
                       [-0.0348,0.0779,0.0429, ...                         %% state == 11  PREPARING FOR SWITCHING
                        -0.1493,0.8580,0.2437,0.8710, ...                  %
                        -0.1493,0.8580,0.2437,0.8710, ...                  %
                         0.0005,0.0793,-0.0014,-0.0051,0.0073,-0.1151, ... %  
                        -0.0015,-0.1109,-0.0001,0.0003,0.0160,0.1630];     %                                  
                       [ 0.0864,0.0258,0.0152, ...                         %% state == 12  LOOKING FOR CONTACT
                         0.1253,0.8135,0.3051,0.7928, ...                  %
                         0.0563,0.6789,0.3340,0.6214, ...                  %
                        -0.0026,0.0225,0.0093,-0.0020,0.0027,-0.0277,...   %
                         0.0107,-0.0741,-0.0001,-0.0120,0.0252,0.1369];    %   
                        zeros(1,ROBOT_DOF)];                               %% NOT USED   

% YOGA MOVESET (LEFT YOGA)
q1 =        [-0.0790,0.2279, 0.4519, ...
             -1.1621,0.6663, 0.4919, 0.9947, ... 
             -1.0717,1.2904,-0.2447, 1.0948, ...
              0.2092,0.2960, 0.0006,-0.1741,-0.1044, 0.0700, ...
              0.3484,0.4008,-0.0004,-0.3672,-0.0530,-0.0875];

q2 =        [-0.0790,0.2279, 0.4519, ...
             -1.1621,0.6663, 0.4965, 0.9947, ...
             -1.0717,1.2904,-0.2493, 1.0948, ...
              0.2092,0.2960, 0.0006,-0.1741,-0.1044,0.0700, ... 
              0.3714,0.9599, 1.3253,-1.6594, 0.6374,-0.0614];
          
q3 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042, ...
             -0.4181, 1.6800,0.7373, 0.3031, ...
              0.2092,0.2960, 0.0006,-0.1741,-0.1044,0.0700, ...
              0.3714,0.9599, 1.3253,-1.6594, 0.6374,-0.0614];
          
q4 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042, ...
             -0.4181, 1.6800,0.7373, 0.3031, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];
          
q5 =        [-0.0790,-0.1273, 0.4519, ...
             -1.1621,0.6663, 0.4965, 0.9947, ...
             -1.0717,1.2904,-0.2493, 1.0948, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];
          
q6 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042, ...
             -0.4181, 1.6800,0.7373, 0.3031, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];
          
q7 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042, ...
             -0.4181, 1.6800,0.7373, 0.3031, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253, -1.6217, 0.6374,-0.0614];
          
q8 =        [-0.0852,-0.4273,0.0821,...
              0.1391, 1.4585,0.2464, 0.3042, ...
             -0.4181, 1.6800,0.7373, 0.3031, ...
              0.2092, 0.3473,0.0006,-0.1741,-0.1044, 0.0700,...
              0.3514, 1.3107,1.3253,-0.0189, 0.6374,-0.0614];
          
Sm.joints_leftYogaRef  = [0,                              q1;
                          1*Sm.smoothingTimeCoM_Joints(4),q2;
                          2*Sm.smoothingTimeCoM_Joints(4),q3;
                          3*Sm.smoothingTimeCoM_Joints(4),q4;
                          4*Sm.smoothingTimeCoM_Joints(4),q5;
                          5*Sm.smoothingTimeCoM_Joints(4),q6;
                          6*Sm.smoothingTimeCoM_Joints(4),q7;
                          7*Sm.smoothingTimeCoM_Joints(4),q8];
                 
Sm.joints_rightYogaRef      = Sm.joints_leftYogaRef;
Sm.joints_rightYogaRef(:,1) = [0;
                               1*Sm.smoothingTimeCoM_Joints(10);
                               2*Sm.smoothingTimeCoM_Joints(10);
                               3*Sm.smoothingTimeCoM_Joints(10);
                               4*Sm.smoothingTimeCoM_Joints(10);
                               5*Sm.smoothingTimeCoM_Joints(10);
                               6*Sm.smoothingTimeCoM_Joints(10);
                               7*Sm.smoothingTimeCoM_Joints(10)]; 

% MIRROR YOGA LEFT MOVESET FOR RIGHT YOGA					 
for i = 1:size(Sm.joints_rightYogaRef,1)	
    
	Sm.joints_rightYogaRef(i,2:4)           = [Sm.joints_rightYogaRef(i,2) -Sm.joints_rightYogaRef(i,3) -Sm.joints_rightYogaRef(i,4)];
	rightArm                                =  Sm.joints_rightYogaRef(i,end-15:end-12);
	Sm.joints_rightYogaRef(i,end-15:end-12) =  Sm.joints_rightYogaRef(i,end-19:end-16);
	Sm.joints_rightYogaRef(i,end-19:end-16) =  rightArm;
	rightLeg                                =  Sm.joints_rightYogaRef(i,end-5:end);
	Sm.joints_rightYogaRef(i,end-5:end)     =  Sm.joints_rightYogaRef(i,end-11:end-6);
	Sm.joints_rightYogaRef(i,end-11:end-6)  =  rightLeg;
end	 

%% References for CoM trajectory (COORDINATOR DEMO ONLY)

% that the robot waits before starting the left-and-right 
Config.noOscillationTime       = 0;   
Config.directionOfOscillation  = [0;0;0];
Config.amplitudeOfOscillation  = 0.0;  
Config.frequencyOfOscillation  = 0.0;

%% Parameters for motors reflected inertia

% inverse of the transmission ratio
Config.invGamma = 100*eye(ROBOT_DOF);
% torso yaw has a bigger reduction ratio
Config.invGamma(3,3) = 200;

% motors inertia (Kg*m^2)
legsMotors_I_m           = 0.0827*1e-4;
torsoPitchRollMotors_I_m = 0.0827*1e-4;
torsoYawMotors_I_m       = 0.0585*1e-4;
armsMotors_I_m           = 0.0585*1e-4;
Config.I_m               = diag([torsoPitchRollMotors_I_m*ones(2,1);
                                 torsoYawMotors_I_m;
                                 armsMotors_I_m*ones(8,1);
                                 legsMotors_I_m*ones(12,1)]);

% gain for feedforward term in joint torques calculation. Valid range: a
% value between 0 and 1
Config.K_ff     = 0;

%% Constraints for QP for balancing

% The friction cone is approximated by using linear interpolation of the circle. 
% So, numberOfPoints defines the number of points used to interpolate the circle 
% in each cicle's quadrant
numberOfPoints               = 4;  
forceFrictionCoefficient     = 1/3;    
torsionalFrictionCoefficient = 1/75;
fZmin                        = 10;

% physical size of the foot                             
feet_size                    = [-0.05  0.10;     % xMin, xMax
                                -0.025 0.025];   % yMin, yMax 
                            
%% Cleanup
clear q1 q2 q3 q4;
