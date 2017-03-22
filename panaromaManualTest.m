function varargout = panaromaManualTest(varargin)
% PANAROMAMANUALTEST MATLAB code for panaromaManualTest.fig
%      PANAROMAMANUALTEST, by itself, creates a new PANAROMAMANUALTEST or raises the existing
%      singleton*.
%
%      H = PANAROMAMANUALTEST returns the handle to a new PANAROMAMANUALTEST or the handle to
%      the existing singleton*.
%
%      PANAROMAMANUALTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANAROMAMANUALTEST.M with the given input arguments.
%
%      PANAROMAMANUALTEST('Property','Value',...) creates a new PANAROMAMANUALTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before panaromaManualTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to panaromaManualTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help panaromaManualTest

% Last Modified by GUIDE v2.5 22-Mar-2017 13:22:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @panaromaManualTest_OpeningFcn, ...
                   'gui_OutputFcn',  @panaromaManualTest_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before panaromaManualTest is made visible.
function panaromaManualTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to panaromaManualTest (see VARARGIN)

% Choose default command line output for panaromaManualTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes panaromaManualTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = panaromaManualTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnOpenImage1.
function btnOpenImage1_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenImage1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.I1 = openImg();
axes(handles.axes1)
imshow(handles.I1);
guidata(hObject, handles);

% --- Executes on button press in btnOpenImage2.
function btnOpenImage2_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenImage2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.I2 = openImg();
axes(handles.axes2)
imshow(handles.I2);
guidata(hObject, handles);


% --- Executes on button press in btnSelectImages.
function btnSelectImages_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelectImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y] = ginput(8);
handles.x = x;
handles.y = y;
display(x);
display(y);
guidata(hObject, handles);


% --- Executes on button press in btnCalH.
function btnCalH_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X1 = zeros(3,4);
X1(3,:) = 1;
X2 = zeros(3,4);
X2(3,:) = 1;
for i=1:4
    X1(1,i) = handles.x(2*i-1);
    X1(2,i) = handles.y(2*i-1);
    X2(1,i) = handles.x(2*i);
    X2(2,i) = handles.y(2*i);
end
H = computeH(X1,X2);
tform = projective2d(H);
% tform = estimateGeometricTransform(X1(1:2,:)',X2(1:2,:)','projective');
RI1 = imref2d(size(handles.I1));
RI2 = imref2d(size(handles.I2));
[I3,RI3] = imwarp(handles.I1,RI1,tform);
figure;
I = imfuse(handles.I2,RI2,I3,RI3,'blend');
imshow(I);