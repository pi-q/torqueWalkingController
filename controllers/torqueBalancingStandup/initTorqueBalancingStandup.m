%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /**
%  * Copyright (C) 2016 CoDyCo
%  * @author: Daniele Pucci
%  * Permission is granted to copy, distribute, and/or modify this program
%  * under the terms of the GNU General Public License, version 2 or any
%  * later version published by the Free Software Foundation.
%  *
%  * A copy of the license can be found at
%  * http://www.robotcub.org/icub/license/gpl.txt
%  *
%  * This program is distributed in the hope that it will be useful, but
%  * WITHOUT ANY WARRANTY; without even the implied warranty of
%  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
%  * Public License for more details
%  */
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables
clc

%% GENERAL SIMULATION INFO
% If you are simulating the robot with Gazebo, 
% remember that you have to launch Gazebo as follow:
% 
% gazebo -slibgazebo_yarp_clock.so
% 
% and set the environmental variable YARP_ROBOT_NAME = icubGazeboSim.
% To do this, you can uncomment the 

% setenv('YARP_ROBOT_NAME','iCubGenova04');
setenv('YARP_ROBOT_NAME','icubGazeboSim');
% setenv('YARP_ROBOT_NAME','iCubGenova02');
%   setenv('YARP_ROBOT_NAME','iCubGazeboV2_5');  

% Simulation time in seconds
Config.SIMULATION_TIME = inf;   

%% PRELIMINARY CONFIGURATIONS 
% Sm.SM_TYPE: defines the kind of state machines that can be chosen.
%
% 'STANDUP': the robot will stand up from a chair. The associated
%            configuration parameters can be found under the folder
%
%            robots/YARP_ROBOT_NAME/initStateMachineStandup.m
%   
% 'COORDINATOR': the robot can either stay still, or follow a desired
%                center-of-mass trajectory. The associated configuration 
%                parameters can be found under the folder:
%
%                app/robots/YARP_ROBOT_NAME/initCoordinator.m
% 
SM_TYPE                      = 'STANDUP';

% Config.SCOPES: if set to true, all visualizers for debugging are active
Config.SCOPES_ALL            = true;

% You can also activate only some specific debugging scopes
Config.SCOPES_EXT_WRENCHES   = false;
Config.SCOPES_GAIN_SCHE_INFO = false;
Config.SCOPES_MAIN           = false;
Config.SCOPES_QP             = false;

% Config.CHECK_LIMITS: if set to true, the controller will stop as soon as 
% any of the joint limit is touched. 
Config.CHECK_LIMITS          = false;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONFIGURATIONS COMPLETED: loading gains and parameters for the specific robot
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WBT_modelName          = 'matlabTorqueBalancing';

% Ports name list
Ports.WBD_LEFTLEG_EE   = '/wholeBodyDynamics/left_leg/cartesianEndEffectorWrench:o';
Ports.WBD_RIGHTLEG_EE  = '/wholeBodyDynamics/right_leg/cartesianEndEffectorWrench:o';
Ports.RIGHT_ARM        = '/wholeBodyDynamics/right_arm/endEffectorWrench:o';
Ports.LEFT_ARM         = '/wholeBodyDynamics/left_arm/endEffectorWrench:o';

% Controller period [s]
Config.Ts              = 0.01; 

addpath('./src/')
addpath(genpath('../../library'));

% Run robot-specific configuration parameters
run(strcat('app/robots/',getenv('YARP_ROBOT_NAME'),'/configRobot.m')); 

% Run demo-specific configuration parameters
Sm.SM_MASK_COORDINATOR = bin2dec('001');
Sm.SM_MASK_STANDUP     = bin2dec('010');

if strcmpi(SM_TYPE, 'COORDINATOR')
    
    Sm.SM_TYPE_BIN = Sm.SM_MASK_COORDINATOR;
    demoSpecificParameters = fullfile('app/robots',getenv('YARP_ROBOT_NAME'),'initCoordinator.m');
    run(demoSpecificParameters);
    % If true, the robot will perform the STANDUP demo
    Config.iCubStandUp = false; 
    
elseif strcmpi(SM_TYPE, 'STANDUP')
    
    Sm.SM_TYPE_BIN = Sm.SM_MASK_STANDUP;
    demoSpecificParameters = fullfile('app/robots',getenv('YARP_ROBOT_NAME'),'initStateMachineStandup.m');
    run(demoSpecificParameters);
    % If true, the robot will perform the STANDUP demo
    Config.iCubStandUp = true; 
end

%% Contact constraints: legs and feet
% feet constraints
[ConstraintsMatrixFeet,bVectorConstraintsFeet] = constraints(forceFrictionCoefficient,numberOfPoints,torsionalFrictionCoefficient,feet_size,fZmin);
% legs constraints
[ConstraintsMatrixLegs,bVectorConstraintsLegs] = constraints(forceFrictionCoefficient,numberOfPoints,torsionalFrictionCoefficient,leg_size,fZmin);

