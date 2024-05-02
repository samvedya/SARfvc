function[No_cls]=select_cls(nclas_data)

if nclas_data<=6
    errordlg('Minimum number of classes in polarimetric data should be 6');
end

switch nclas_data
    case 7
        C={'6'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
       

    case 8
        C={'6','7'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
       
    case 9
        C={'6','7','8'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
        
    case 10
        C={'6','7','8','9'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
       
    case 11
        C={'6','7','8','9','10'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
      
    case 12
        C={'6','7','8','9','10','11'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
      
    case 13
        C={'6','7','8','9','10','11','12'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
      
    case 14
        C={'6','7','8','9','10','11','12','13'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
       
    case 15
        C={'6','7','8','9','10','11','12','13','14'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
       
     case 16
        C={'6','7','8','9','10','11','12','13','14'};
        P='Select Number of classes';
        selection = listdlg('ListString',C, 'SelectionMode','single', 'PromptString',P);
        No_cls=str2num(cell2mat(C(selection)));
        
     otherwise
        error("Minimum nclas value should be between 6 and 14")
end
end