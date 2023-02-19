/*! CellEdit 1.0.19
 * ©2016 Elliott Beaty - datatables.net/license
 */

/**
 * @summary     CellEdit
 * @description Make a cell editable when clicked upon
 * @version     1.0.19
 * @file        dataTables.editCell.js
 * @author      Elliott Beaty
 * @contact     elliott@elliottbeaty.com
 * @copyright   Copyright 2016 Elliott Beaty
 *
 * This source file is free software, available under the following license:
 *   MIT license - http://datatables.net/license/mit
 *
 * This source file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.
 *
 * For details please refer to: http://www.datatables.net
 */

jQuery.fn.dataTable.Api.register('MakeCellsEditable()', function (settings) {
    var table = this.table();
	
	// 엔터를 치거나(onkeyup) 포커스 아웃(onfocusout)이 되면 반영을 해야 한다..
	// 그런데 이게 2번을 수행하기 되면 에러가 나게 된다.
	var _inputEditing = false ; // 에디팅이 시작되었는지 여부
	var _inputTypeStyle = ""; 
	
    jQuery.fn.extend({
        // UPDATE editing
        updateEditableCell: function (callingElement) {
			
			if ( _inputEditing == false ) { return ;} // 에디팅이 시작되었는지 여부
			_inputEditing = false ; // 한번만 수행하기 위해서 에디팅 종료로 표시
			
			//console.log("_inputEditing: " + _inputEditing );
			//console.log("_inputTypeStyle: " + _inputTypeStyle );
			
			
            // Need to redeclare table here for situations where we have more than one datatable on the page. See issue6 on github
            var table = $(callingElement).closest("table").DataTable().table();
            var row = table.row($(callingElement).parents('tr'));
            var cell = table.cell($(callingElement).parents('td, th'));
            var columnIndex = cell.index().column;
            var inputField =getInputField(callingElement);

            // Update
			var oldValue = cell.data(); // 이전등록값
            var newValue = inputField.val(); // 신규입력된 값
			
			console.log("oldValue: " + oldValue + " -> newValue: " + newValue );
			
			// 숫자 검증
			switch (_inputTypeStyle)
			{
				case "number":
				case "number-confirm":
					if ( isNumeric(newValue) == false) // 숫자가 아닌면
					{
						newValue = "0";
					}
				break;
			}
			
			// 이전과 이후 값의 변경여부 파악
			var _blnChange = false ;// 값의 변경여부를 호출자에 다시 넘겨준다.
			if ( newValue != oldValue )
			{
				_blnChange = true;
			}
			
			// 값이 변경된 경우만 테이블을 다시 그린다.
			if ( _blnChange == false) 
			{
				cell.data(oldValue); // 변경된 값을 넣어준다 그래야 input 이 사라진다.
			} 
			else 
			{ 
				// 값이 수정된 경우 
				if (!newValue && ((settings.allowNulls) && settings.allowNulls != true)) {
					// If columns specified
					if (settings.allowNulls.columns) {
						// If current column allows nulls
						if (settings.allowNulls.columns.indexOf(columnIndex) > -1) {
							_update(newValue);
						} else {
							_addValidationCss();
						}
						// No columns allow null
					} else if (!newValue) {
						_addValidationCss();
					}
					//All columns allow null
				} else if (newValue && settings.onValidate) {
					if (settings.onValidate(cell, row, newValue)) {
						_update(newValue);
					} else {
						_addValidationCss();
					}
				}
				else {
					_update(newValue);
				}
				
				// Get current page -- 현재 페지이
				var currentPageIndex = table.page.info().page;

				//Redraw table
				table.page(currentPageIndex).draw(false); // 페이징없이 다시 그리기

			} // end _blnChange
			
			// ======================
			// 규칙 css 적용
			// ======================
            function _addValidationCss() {
                // Show validation error
                if (settings.allowNulls.errorClass) {
                    $(inputField).addClass(settings.allowNulls.errorClass);
                } else {
                    $(inputField).css({ "border": "red solid 1px" });
                }
            }
			// ======================
			// 신규값 적용하기
			// ======================
            function _update(newValue) {
                
				cell.data(newValue); // 변경된 값을 넣어준다,
				
                //Return cell & row.
                settings.onUpdate(cell, row, oldValue , newValue , _blnChange);
            }
			
        },
        // CANCEL
        cancelEditableCell: function (callingElement) {
            var table = $(callingElement.closest("table")).DataTable().table();
            var cell = table.cell($(callingElement).parents('td, th'));
            // Set cell to it's original value
            cell.data(cell.data());

            // Redraw table
            table.draw(false);
        }  
    });

    // Destroy
    if (settings === "destroy") {
        $(table.body()).off("click", "td"); // 이벤트 해제
        table = null; // 데이터테이블을 완전히 해제.
    }

    if (table != null) {
        // On cell click
        $(table.body()).on('click', 'td', function () {

			// 행이 없는 경우 나간다.
			if ( table.data().count() <=0 ) { return;}

            var currentColumnIndex = table.cell(this).index().column;

            // DETERMINE WHAT COLUMNS CAN BE EDITED
            if ((settings.columns && settings.columns.indexOf(currentColumnIndex) > -1) || (!settings.columns)) {
                var row = table.row($(this).parents('tr'));
                editableCellsRow = row;

                var cell = table.cell(this).node();
                var oldValue = table.cell(this).data();
                // Sanitize value
                oldValue = sanitizeCellValue(oldValue);

                // Show input
                if (!$(cell).find('input').length && !$(cell).find('select').length && !$(cell).find('textarea').length) {
					
					// 에디팅 유형-유효성 검사를 위해서 inputTypeStyle 을 담아준다.숫자 검사를 위해서
					if(settings.inputTypes){
						$.each(settings.inputTypes, function (index, setting) {
							if (setting.column == currentColumnIndex) { // 해당 컬럼인 경우
								inputSetting = setting;
								_inputTypeStyle = inputSetting.type.toLowerCase();
							}
						});
					}
					
					
                    // Input CSS
                    var input = getInputHtml(currentColumnIndex, settings, oldValue);
                    $(cell).html(input.html);
					_inputEditing = true ; // 에디팅이 시작되었는지 여부
                    if (input.focus) {
                        $('#ejbeatycelledit').focus();
                    }
                }
            }
        });
    }

}); // extension

function getInputHtml(currentColumnIndex, settings, oldValue) {
    var inputSetting, inputType, input, inputCss, confirmCss, cancelCss, startWrapperHtml = '', endWrapperHtml = '', listenToKeys = true;

    input = {"focus":true,"html":null};

    if(settings.inputTypes){
		$.each(settings.inputTypes, function (index, setting) {
			if (setting.column == currentColumnIndex) {
				inputSetting = setting;
				inputType = inputSetting.type.toLowerCase();
			}
		});
	}

    if (settings.inputCss) { inputCss = settings.inputCss; }
    if (settings.wrapperHtml) {
        var elements = settings.wrapperHtml.split('{content}');
        if (elements.length === 2) {
            startWrapperHtml = elements[0];
            endWrapperHtml = elements[1];
        }
    }
    
    if (settings.confirmationButton) {
        if (settings.confirmationButton.listenToKeys) { listenToKeys = settings.confirmationButton.listenToKeys; }
        confirmCss = settings.confirmationButton.confirmCss;
        cancelCss = settings.confirmationButton.cancelCss;
        inputType = inputType + "-confirm";
    }
	
    switch (inputType) {
        case "list":
            input.html = startWrapperHtml + "<select class='" + inputCss + "' onchange='$(this).updateEditableCell(this);'>";
            $.each(inputSetting.options, function (index, option) {
                if (oldValue == option.value) {
                   input.html = input.html + "<option value='" + option.value + "' selected>" + option.display + "</option>"
                } else {
                   input.html = input.html + "<option value='" + option.value + "' >" + option.display + "</option>"
                }
            });
            input.html = input.html + "</select>" + endWrapperHtml;
            input.focus = false;
            break;
        case "list-confirm": // List w/ confirm
            input.html = startWrapperHtml + "<select class='" + inputCss + "'>";
            $.each(inputSetting.options, function (index, option) {
                if (oldValue == option.value) {
                   input.html = input.html + "<option value='" + option.value + "' selected>" + option.display + "</option>"
                } else {
                   input.html = input.html + "<option value='" + option.value + "' >" + option.display + "</option>"
                }
            });
            input.html = input.html + "</select>&nbsp;<a href='javascript:void(0);' class='" + confirmCss + "' onclick='$(this).updateEditableCell(this);'>확인</a> <a href='javascript:void(0);' class='" + cancelCss + "' onclick='$(this).cancelEditableCell(this)'>취소</a>" + endWrapperHtml;
            input.focus = false;
            break;
        case "datepicker": //Both datepicker options work best when confirming the values
        case "datepicker-confirm":
            // Makesure jQuery UI is loaded on the page
            if (typeof jQuery.ui == 'undefined') {
                alert("jQuery UI is required for the DatePicker control but it is not loaded on the page!");
                break;
            }
	        jQuery(".datepick").datepicker("destroy");
	        input.html = startWrapperHtml + "<input id='ejbeatycelledit' type='text' name='date' class='datepick " + inputCss + "'   value='" + oldValue + "'></input> &nbsp;<a href='javascript:void(0);' class='" + confirmCss + "' onclick='$(this).updateEditableCell(this)'>Confirm</a> <a href='javascript:void(0);' class='" + cancelCss + "' onclick='$(this).cancelEditableCell(this)'>Cancel</a>" + endWrapperHtml;
	        setTimeout(function () { //Set timeout to allow the script to write the input.html before triggering the datepicker
	            var icon = "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif";
                // Allow the user to provide icon
	            if (typeof inputSetting.options !== 'undefined' && typeof inputSetting.options.icon !== 'undefined') {
	                icon = inputSetting.options.icon;
	            }
	            var self = jQuery('.datepick').datepicker(
                    {
                        showOn: "button",
                        buttonImage: icon,
                        buttonImageOnly: true,
                        buttonText: "Select date"
                    });
	        },100);
	        break;
        case "text-confirm": // text input w/ confirm
            input.html = startWrapperHtml + "<input id='ejbeatycelledit' class='" + inputCss + "' value='"+oldValue+"'" + (listenToKeys ? " onkeyup='if(event.keyCode==13) {$(this).updateEditableCell(this);} else if (event.keyCode===27) {$(this).cancelEditableCell(this);}'" : "") + "></input>&nbsp;<a href='javascript:void(0);' class='" + confirmCss + "' onclick='$(this).updateEditableCell(this)'>확인</a> <a href='javascript:void(0);' class='" + cancelCss + "' onclick='$(this).cancelEditableCell(this)'>취소</a>" + endWrapperHtml;
            break;
        case "undefined-confirm": // text input w/ confirm
            input.html = startWrapperHtml + "<input id='ejbeatycelledit' class='" + inputCss + "' value='" + oldValue + "'" + (listenToKeys ? " onkeyup='if(event.keyCode==13) {$(this).updateEditableCell(this);} else if (event.keyCode===27) {$(this).cancelEditableCell(this);}'" : "") + "></input>&nbsp;<a href='javascript:void(0);' class='" + confirmCss + "' onclick='$(this).updateEditableCell(this)'>확인</a> <a href='javascript:void(0);' class='" + cancelCss + "' onclick='$(this).cancelEditableCell(this)'>취소</a>" + endWrapperHtml;
            break;
        case "textarea":
            input.html = startWrapperHtml + "<textarea id='ejbeatycelledit' class='" + inputCss + "'  onfocusout='$(this).updateEditableCell(this)' >"+oldValue+"</textarea>" + endWrapperHtml;
            break;
        case "textarea-confirm":
            input.html = startWrapperHtml + "<textarea id='ejbeatycelledit' class='" + inputCss + "'>"+oldValue+"</textarea><a href='javascript:void(0);' class='" + confirmCss + "' onclick='$(this).updateEditableCell(this)'>Confirm</a> <a href='javascript:void(0);' class='" + cancelCss + "' onclick='$(this).cancelEditableCell(this)'>Cancel</a>" + endWrapperHtml;
            break;
		case "number-confirm" :
			input.html = startWrapperHtml + "<input id='ejbeatycelledit' type='number' class='" + inputCss + "' value='"+oldValue+"'" + (listenToKeys ? " onkeyup='if(event.keyCode==13) {$(this).updateEditableCell(this);} else if (event.keyCode===27) {$(this).cancelEditableCell(this);}'" : "") + "></input>&nbsp;<a href='javascript:void(0);' class='" + confirmCss + "' onclick='$(this).updateEditableCell(this)'>확인</a> <a href='javascript:void(0);' class='" + cancelCss + "' onclick='$(this).cancelEditableCell(this)'>취소</a>" + endWrapperHtml;
			break;
		case "number" :
			input.html = startWrapperHtml + "<input id='ejbeatycelledit' class='" + inputCss + "'  value='" + oldValue + "' onfocusout='$(this).updateEditableCell(this);' " + (listenToKeys ? " onkeyup='if(event.keyCode==13) {$(this).updateEditableCell(this);} else if (event.keyCode===27) {$(this).cancelEditableCell(this);}'" : " ") +"></input>" + endWrapperHtml;
			break;
        default: // text input , listenToKeys 활성화시 엔터와 ESC 면 수행 , 비활성화 포커스 아웃시 반영
            input.html = startWrapperHtml + "<input id='ejbeatycelledit' class='" + inputCss + "'  value='" + oldValue + "' onfocusout='$(this).updateEditableCell(this);' " + (listenToKeys ? " onkeyup='if(event.keyCode==13) {$(this).updateEditableCell(this);} else if (event.keyCode===27) {$(this).cancelEditableCell(this);}'" : " ") +"></input>" + endWrapperHtml;
            break;
    }
    return input;
}
 
function getInputField(callingElement) {
    // Update datatables cell value
    var inputField;
    switch ($(callingElement).prop('nodeName').toLowerCase()) {
        case 'a': // This means they're using confirmation buttons
            if ($(callingElement).siblings('input').length > 0) {
                inputField = $(callingElement).siblings('input');
            }
            if ($(callingElement).siblings('select').length > 0) {
                inputField = $(callingElement).siblings('select');
            }
            if ($(callingElement).siblings('textarea').length > 0) {
                inputField = $(callingElement).siblings('textarea');
            }
        break;
        default:
            inputField = $(callingElement);
    }
    return inputField;
}

function sanitizeCellValue(cellValue) {
    if (typeof (cellValue) === 'undefined' || cellValue === null || cellValue.length < 1) {
        return "";
    }

    // If not a number
    if (isNaN(cellValue)) {
        // escape single quote
        cellValue = cellValue.replace(/'/g, "&#39;");
    }
    return cellValue;
}

// 숫자 검사
function isNumeric(num, optionNo){
	
	// 좌우 trim(공백제거)을 해준다.
	num = String(num).replace(/^\s+|\s+$/g, "");

	if(typeof optionNo == "undefined") {optionNo ="1";}
	
	var regex = /^[0-9]$/g; //  only 숫자만 정규식
	switch (optionNo)
	{
		case "1":// 모든 10진수 (부호 선택, 자릿수구분기호 선택, 소수점 선택)
			regex = /^[+\-]?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
			break;
		case "2":// 부호 미사용, 자릿수구분기호 선택, 소수점 선택
			regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
			break;
		case "3":// 부호 미사용, 자릿수구분기호 미사용, 소수점 선택
			regex = /^[0-9]+(\.[0-9]+)?$/g;
			break;
		default :// only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
			regex = /^[0-9]$/g;
			break;
	}
	 
	// 정규식 검사
	if( regex.test(num) ){
		num = num.replace(/,/g, "");
		return isNaN(num) ? false : true;
	} 
	else 
	{ 
		return false;  
	}
}
