function varargout = IGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @IGUI_OutputFcn, ...
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

%----------------------------------------------------------------------

function IGUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.polyOrder = 0;
handles.counter = 1;
handles.Xs = [];
handles.Ys = [];
guidata(hObject, handles);

%------------------------------------------------------------------------

function varargout = IGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% -------------------------------------------------------------
function interpolationMenu_Callback(hObject, eventdata, handles)
set(handles.solve, 'enable','off')
 set(handles.enterOrder, 'enable', 'on');
%----------------------------------------------------------------
function interpolationMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {"Newton", "Lagrange"});

% ----------------------------------------------------------------
function addPoint_Callback(hObject, eventdata, handles)
xPoint = str2double(get(handles.editPoint, 'String'));
yValue = str2double(get(handles.editValue, 'String'));
if (isnan(xPoint) || isnan(yValue))
	msgbox('InValid Input!! Make sure points and Values are numbers');
    return;
end
handles.Xs(handles.counter) = xPoint;
handles.Ys(handles.counter) = yValue;
handles.counter = handles.counter + 1;
guidata(hObject, handles);

if handles.counter > handles.polyOrder
    set(handles.addPoint, 'enable','off')
    set(handles.solve, 'enable','on')
end


%-----------------------------------------------------------------

function solve_Callback(hObject, eventdata, handles)
global o;
popup_sel_index = get(handles.interpolationMenu, 'Value');
switch popup_sel_index
    case 1
    	[f exTime]= DividedDifference(handles.Xs, handles.Ys);
        o = resultFunction(f);
        plottingInterpolation(handles, f, handles.Xs, handles.Ys);
        string = 'Exe Time : ';
        string = strcat(string, num2str(exTime));
        set(handles.exTime, 'visible','on');
        set(handles.exTime, 'String', string);
        set(handles.resultFunc, 'visible','on');
         set(handles.resultFunc, 'String', char(f));
        set(handles.find, 'enable', 'on');
    case 2
        [f exTime]= LaGrange(handles.Xs, handles.Ys);
        o = resultFunction(f);
        plottingInterpolation(handles, f, handles.Xs, handles.Ys);
        string = 'Exe Time : ';
        string = strcat(string, num2str(exTime));
        set(handles.exTime, 'visible','on');
        set(handles.exTime, 'String', string);
         set(handles.resultFunc, 'visible','on');
        set(handles.resultFunc, 'String', char(f));
        set(handles.find, 'enable', 'on');
end

%-------------------------------------------------------------------

function editPolyOrder_Callback(hObject, eventdata, handles)

%--------------------------------------------------------------------

function editPolyOrder_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------------

function editPoint_Callback(hObject, eventdata, handles)

%----------------------------------------------------------------------

function editPoint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------

function editValue_Callback(hObject, eventdata, handles)

%-----------------------------------------------------------------------

function editValue_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------------

function enterOrder_Callback(hObject, eventdata, handles)
polynomialOrder = str2double(get(handles.editPolyOrder, 'String'));
if (isnan(polynomialOrder) || polynomialOrder < 0)
	msgbox('InValid Input!! Make sure polynomial order is higher than zero');
    return;
end

handles.polyOrder = polynomialOrder + 1;
guidata(hObject, handles);

set(handles.addPoint, 'enable', 'on');
set(handles.solve, 'enable','off');
set(handles.exTime, 'visible','off');
set(handles.resultFunc, 'visible','off');
axes(handles.axes1);
cla;
set(handles.find, 'enable', 'off');
%------------------------------------------------------------------

function exTime_Callback(hObject, eventdata, handles)


function exTime_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------

function find_Callback(hObject, eventdata, handles)

global q;
queries = get(q);
x = str2double(get(handles.editfindX, 'String'));
if (isnan(x))
    msgbox('InValid Input!! point must be a valid number');
    return;
end
global o;
result = get(o);
y = feval(result.f,x);
axes(handles.axes1);
grid on;
plot([x x], [y y], 'x')
if(~isempty(queries))
if(~isempty(queries.qs))
   set(handles.editfindX, 'string', num2str(queries.qs(1))); 
  queries.qs(1) = [];
  q = queryPoints(queries.qs);
end
end

%---------------------------------------------------------------------------

function editfindX_CreateFcn(hObject, eventdata, handles)
function editfindX_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
 set(handles.find, 'enable','off');
[filename1,filepath1]=uigetfile({'*.txt','All Files'},...
  'Select Data File 1');
s = strcat(filepath1 ,filename1);
 [order, xs, ys, qs,method] = readFile2(s);
 global q;
 set(handles.editPolyOrder, 'String', order);
 if ((length(xs) == length(ys)) && (length(xs) == str2double(order)+1))
 handles.Xs = xs;
 handles.Ys = ys;
 handles.polyOrder = order + 1;
 set(handles.interpolationMenu, 'Value',str2double(method));
 set(handles.addPoint, 'enable','off')
 set(handles.solve, 'enable','on') 
 set(handles.editfindX, 'string', qs(1));
 qs(1) = [];
 q = queryPoints(qs);
 set(handles.editPoint, 'string', xs(1));
 set(handles.editValue, 'string', ys(1));
 guidata(hObject, handles);

  else 
	msgbox('InValid Inputs!');
  end

%-----------------------------------------------------------------

function resultFunc_Callback(hObject, eventdata, handles)

function resultFunc_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
