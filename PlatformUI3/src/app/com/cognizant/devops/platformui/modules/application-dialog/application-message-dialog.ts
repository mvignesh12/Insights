/*********************************************************************************
 * Copyright 2017 Cognizant Technology Solutions
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License.  You may obtain a copy
 * of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
 * License for the specific language governing permissions and limitations under
 * the License.
 *******************************************************************************/

import { Component, OnInit, Inject } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';

@Component({
    selector: 'application-message-dialog',
    templateUrl: 'application-message-dialog.html',
    styleUrls: ['./../home.module.css']
})

export class ApplicationMessageDialog implements OnInit {
    colorCode: String;
    dialogTitle: String;
    svgCustomIcon: String;
    constructor(public dialogRef: MatDialogRef<ApplicationMessageDialog>, @Inject(MAT_DIALOG_DATA) public data: any) {
        if (data.type == 'SUCCESS') {
            this.colorCode = "#008000";
            this.dialogTitle = "Success";
            this.svgCustomIcon = "success";
        } else if (data.type == 'WARN') {
            this.colorCode = "#FFFF00"
            this.dialogTitle = "warning";
            this.svgCustomIcon = "";
        } else if (data.type == 'ERROR') {
            this.colorCode = "#ff0000";
            this.dialogTitle = "Error";
            this.svgCustomIcon = "error";
        }
    }

    ngOnInit() {
    }

    onCloseClick(): void {
        this.dialogRef.close();
    }
}