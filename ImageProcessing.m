function varargout = ImageProcessing(varargin)
% IMAGEPROCESSING MATLAB code for ImageProcessing.fig
%      IMAGEPROCESSING, by itself, creates a new IMAGEPROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGEPROCESSING returns the handle to a new IMAGEPROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGEPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEPROCESSING.M with the given input arguments.
%
%      IMAGEPROCESSING('Property','Value',...) creates a new IMAGEPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the IMAGEPROCESSING before ImageProcessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageProcessing_OpeningFcn via varargin.
%
%      *See IMAGEPROCESSING Options on GUIDE's Tools menu.  Choose "IMAGEPROCESSING allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageProcessing

% Last Modified by GUIDE v2.5 21-Feb-2019 10:40:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageProcessing_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageProcessing_OutputFcn, ...
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


% --- Executes just before ImageProcessing is made visible.
function ImageProcessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageProcessing (see VARARGIN)

% Choose default command line output for ImageProcessing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageProcessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageProcessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double


% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_OpenImage.
function btn_OpenImage_Callback(hObject, eventdata, handles)
global img;
global name;
[Filename, Pathname] = uigetfile('*.jpg','File Selector'); %Get the image path 
name = strcat(Pathname,Filename); % Get the image name with directory
img = imread(name); % Read the image
set(handles.path,'string',name); % Set the path label to image path
set(handles.txXrange,'string',size(img,1)); % Set the Xrange editText to row length
set(handles.txYrange,'string',size(img,2)); % Set the Yrange editText to column length
axes(handles.axesImg); % Set the axes to image
imshow(img); % Showing the image

% --- Executes on button press in btn_Grayscale.
function btn_Grayscale_Callback(hObject, eventdata, handles)
global img;
if(size(img,3) == 3) % Checking if the image consists of 3 layers
    % Put each R G B array to each variable
    R = img(:,:,1);
    G = img(:,:,2); 
    B = img(:,:,3);
    % Sum the R, G, B channel
    sum_R = sum(R);
    sum_G = sum(G);
    sum_B = sum(B);
    % Percentage with comparison R : G : B (sum = 1)
    x = sum_R / (sum_R + sum_G + sum_B);
    y = sum_G / (sum_R + sum_G + sum_B);
    z = sum_B / (sum_R + sum_G + sum_B);
    % Formula to get a grayscale image with the comparison R : G : B
    img = x * R + y * G + z * B; 
    imshow(img); %Showing the image
end

% --- Executes on button press in btnPercentBright.
function btnPercentBright_Callback(hObject, eventdata, handles)
global img;
img = double(img);
brightVal = str2double(get(handles.txPercentBright, 'String')); %Get the bright value from editText
if(brightVal > 100 || brightVal < -100) % Check if the input invalid
    msgbox('Please enter a value between -100 and 100', 'Error','error'); % Show error message
else
    if(brightVal > 0)
        % If the bright value (+) then it will increase the image brightness by
        % multiplying each pixel with bright value
        img = img*((100 + brightVal) / 100);
    else
        % If the bright value (-) then it will decrease the image brightness by
        % divide each pixel with bright value
        img = img/((100 + abs(brightVal)) / 100); 
    end
    viewImg = uint8(img); % Change the image data type from double to uint8
    imshow(viewImg); % Showing the image
end

function txPercentBright_Callback(hObject, eventdata, handles)
% hObject    handle to txPercentBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txPercentBright as text
%        str2double(get(hObject,'String')) returns contents of txPercentBright as a double

% --- Executes during object creation, after setting all properties.
function txPercentBright_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txPercentBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btnPercentBright.
function btnValueBright_Callback(hObject, eventdata, handles)
global img;
img = double(img);
brightVal = str2double(get(handles.txValueBright, 'String')); % Get the bright value from editText
if(brightVal > 100 || brightVal < -100) % Check if the input invalid
    msgbox('Please enter a value between -100 and 100', 'Error','error'); % Show error message
else
    img = img + brightVal; % Sum the bright value to each pixel of the image
    viewImg = uint8(img); % Change the image data type from double to uint8
    imshow(viewImg); % Showing the image
end

function txValueBright_Callback(hObject, eventdata, handles)
% hObject    handle to txValueBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txValueBright as text
%        str2double(get(hObject,'String')) returns contents of txValueBright as a double

% --- Executes during object creation, after setting all properties.
function txValueBright_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txValueBright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txXrange_Callback(hObject, eventdata, handles)
% hObject    handle to txXrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txXrange as text
%        str2double(get(hObject,'String')) returns contents of txXrange as a double

% --- Executes during object creation, after setting all properties.
function txXrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txXrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txYrange_Callback(hObject, eventdata, handles)
% hObject    handle to txYrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txYrange as text
%        str2double(get(hObject,'String')) returns contents of txYrange as a double

% --- Executes during object creation, after setting all properties.
function txYrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txYrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txXstart_Callback(hObject, eventdata, handles)
% hObject    handle to txXstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txXstart as text
%        str2double(get(hObject,'String')) returns contents of txXstart as a double

% --- Executes during object creation, after setting all properties.
function txXstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txXstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txYstart_Callback(hObject, eventdata, handles)
% hObject    handle to txYstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txYstart as text
%        str2double(get(hObject,'String')) returns contents of txYstart as a double

% --- Executes during object creation, after setting all properties.
function txYstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txYstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btnCrop.
function btnCrop_Callback(hObject, eventdata, handles)
global img;
xRange = str2double(get(handles.txXrange, 'String'));
yRange = str2double(get(handles.txYrange, 'String'));
xStart = str2double(get(handles.txXstart, 'String')); % Get the value of X Start from editText
xEnd = str2double(get(handles.txXend, 'String')); % Get the value of X End from editText
yStart = str2double(get(handles.txYstart, 'String')); % Get the value of Y Start from editText
yEnd = str2double(get(handles.txYend, 'String')); % Get the value of Y End from editText
if(xStart < 1 || xStart > xRange || xEnd < 1 || xEnd > xRange) % Check if the input invalid
    msgbox(sprintf('Please enter a value between 0 and %s for X range', num2str(xRange)), 'Error','error'); % Show error message
elseif(yStart < 1 || yStart > yRange || yEnd < 1 || yEnd > yRange)
    msgbox(sprintf('Please enter a value between 0 and %s for Y range', num2str(xRange)), 'Error','error'); % Show error message
else
    img = double(img(xStart:xEnd, yStart:yEnd, :)); % Cropping image
    viewImg = uint8(img);
    set(handles.txXrange,'string',size(viewImg,1)); % Set the Xrange editText to row length
    set(handles.txYrange,'string',size(viewImg,2)); % Set the Yrange editText to column length
    imshow(viewImg); % Showing the image
end

function txXend_Callback(hObject, eventdata, handles)
% hObject    handle to txXend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txXend as text
%        str2double(get(hObject,'String')) returns contents of txXend as a double

% --- Executes during object creation, after setting all properties.
function txXend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txXend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txYend_Callback(hObject, eventdata, handles)
% hObject    handle to txYend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txYend as text
%        str2double(get(hObject,'String')) returns contents of txYend as a double

% --- Executes during object creation, after setting all properties.
function txYend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txYend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btnZoomIn.
function btnZoomIn_Callback(hObject, eventdata, handles)
global img;
% Get the zoom-in area
img = double(img(ceil(end/4):ceil(end-end/4), ceil(end/4):ceil(end-end/4), :));
rows = size(img,1); % Get the row length
cols = size(img,2); % Get the column length
zoomImg = zeros(2*rows, 2*cols, 3); % Make a new array for zoom-in image
% Copying each pixel from original image to the zoomImg
for i=1 : rows
    for j=1 : cols
        for k=(2*i)-1 : (2*i)
            for l=(2*j)-1 : (2*j)
                zoomImg(k, l, :) = img(i, j, :);
            end
        end
    end
end
img = zoomImg;
viewImg = uint8(img); % Change the image data type from double to uint8
set(handles.txXrange,'string',size(viewImg,1)); % Set the Xrange editText to row length
set(handles.txYrange,'string',size(viewImg,2)); % Set the Yrange editText to column length
imshow(viewImg); % Showing the image

% --- Executes on button press in btnZoomOut.
function btnZoomOut_Callback(hObject, eventdata, handles)
global img;
rows = size(img,1); % Get the image-row length
cols = size(img,2); % Get the image-column length
% Adding pixel 0 to every side of image as the frame of zoom-out image
img = double(padarray(img,[ceil(rows/2) ceil(cols/2)], 0, 'both'));
zoomImg = zeros(rows, cols, 3); % Make a new array for zoom-in image
% Copying each pixel from original image to the zoomImg
for i=1 : rows
    for j=1 : cols
        sum = zeros(1, 1, 3);
        for k=(2*i)-1 : (2*i)
            for l=(2*j)-1 : (2*j)
                sum = sum + img(k, l, :);
            end
            % insert 4 pixels from the original image into 1 pixel of zoom-out image
            zoomImg(i, j, :) = floor(sum/4);
        end
    end
end
img = zoomImg;
viewImg = uint8(img); % Change the image data type from double to uint8
set(handles.txXrange,'string',size(viewImg,1)); % Set the Xrange editText to row length
set(handles.txYrange,'string',size(viewImg,2)); % Set the Yrange editText to column length
imshow(uint8(viewImg)); % Showing the image

% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
global name;
global img;
img = imread(name); % Read the image
axes(handles.axesImg); % Set the axes to image
set(handles.txXrange,'string',size(img,1)); % Set the Xrange editText to row length
set(handles.txYrange,'string',size(img,2)); % Set the Yrange editText to column length
imshow(img); % Showing the image

% --- Executes on button press in btnHisteq.
function btnHisteq_Callback(hObject, eventdata, handles)
% hObject    handle to btnHisteq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
