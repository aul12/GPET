var fs = require('fs');

var App = {
    STATES: {
        START: 0,
        FILE_INPUT: 1,
        X_COL: 2,
        Y_COL: 3,
        FILE_OUTPUT: 4
    },

    init: function(){
        var params = process.argv;
        params.shift();
        params.shift();
        var config = this.parseCliParameters(params);
        if(!config.valid)
            return;
        var self = this;
        fs.readFile(config.fileNameInput, "utf8", function (err, data) {
            if (err) {
                console.warn(err);
            } else {
                var vars = self.parseFile(data, config);
                var linRegParams = self.getLinRegParams(vars);
                console.log("Linear equation:");
                console.log("y = "+linRegParams.m+"*x + "+linRegParams.c+"\n");

                console.log("CSV File:");
                var csv = "";
                var lines = data.split(/\r?\n/);
                for(var c=0; c<lines.length; c++){
                    csv += lines[c] + " " +(linRegParams.m * vars[c].x + linRegParams.c) + "\n";
                }
                console.log(csv);

                fs.writeFile(config.fileNameOutput, csv);
            }
        });
    },

    parseCliParameters: function(params){
        var res = {
            fileNameInput: null, xCol: 0, yCol:0, fileNameOutput: null, valid: true
        };

        if(params.length === 0){
            printHelp();
            return res;
        }

        var state = this.STATES.START;

        function printHelp() {
            res.valid = false;
            console.log("LinReg\tv.0.1\n");
            console.log("-i [FILE_INPUT]\t The name of the csv input file");
            console.log("-o [FILE_OUTPUT]\t The name of the csv output file, if this is not set the content will only be written to stdout");
            console.log("-xc [X_COLUMN]\t The (zero-indexed) number of the column the x-Axis values are in");
            console.log("-yc [Y_COLUMN]\t The (zero-indexed) number of the column the y-Axis values are in");
        }

        while(params.length > 0){
            var head =  params.shift();
            switch(state){
                case this.STATES.START:
                    switch(head){
                        case "-i":
                            state = this.STATES.FILE_INPUT;
                            break;
                        case "-xc":
                            state = this.STATES.X_COL;
                            break;
                        case "-yc":
                            state = this.STATES.Y_COL;
                            break;
                        case "-o":
                            state = this.STATES.FILE_OUTPUT;
                            break;
                        default:
                            printHelp();
                            break;
                    }
                    break;
                case this.STATES.FILE_INPUT:
                    res.fileNameInput = head;
                    state = this.STATES.START;
                    break;
                case this.STATES.X_COL:
                    res.xCol = Number(head);
                    state = this.STATES.START;
                    break;
                case this.STATES.Y_COL:
                    res.yCol = Number(head);
                    state = this.STATES.START;
                    break;
                case this.STATES.FILE_OUTPUT:
                    res.fileNameOutput = head;
                    state = this.STATES.START;
                    break;
                default:
                    printHelp();
                    state = this.STATES.START;
                    break;
            }
        }
        return res;
    },

    parseFile: function (data, params) {
        var lines = data.split(/\r?\n/);
        var res = [];

        for(var c=0; c<lines.length; c++){
            var cells = lines[c].split(" ");
            res.push({
                x: Number(cells[params.xCol]),
                y: Number(cells[params.yCol])
            })
        }
        return res;
    },
    
    getLinRegParams: function (vals) {
        var xAv=0, yAv=0, sumSqX = 0, sumXY=0;
        var n = vals.length;
        for(var c=0; c<vals.length; c++){
            xAv += vals[c].x;
            yAv += vals[c].y;
            sumSqX += vals[c].x * vals[c].x;
            sumXY += vals[c].x * vals[c].y;
        }
        xAv /= n;
        yAv /= n;

        var b = (sumXY - n*xAv*yAv)/(sumSqX - n*xAv*xAv);
        var a = yAv - b * xAv;

        return {c: a, m: b};
    }
};

App.init();
