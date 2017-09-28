#!/usr/bin/node

var req = require('request');
var fs = require('fs');
var myJSON = process.argv[2];
var callback = function (err, data) {
  if (err) {
    return (console.log(err));
  }
};
var savepath = (process.cwd() + '/');

// Get content from file
var contents = fs.readFileSync(myJSON);

// Define to JSON type
var jsonContent = JSON.parse(contents);

// Make new project directory
fs.mkdir(jsonContent.tasks[1]["github_dir"], (callback));

// Create empty files inside directory
for (var item of jsonContent.tasks) {
  if (item.github_file.match( /\d+/g )) {
    fs.open(savepath +
	    item.github_dir +
	    '/' +
	    item.github_file, 'w', (callback));
  };
};

// Create README file containing description of project
fs.writeFile(savepath +
	     jsonContent.tasks[1]["github_dir"] +
	     '/README.md', jsonContent.description, (callback));
