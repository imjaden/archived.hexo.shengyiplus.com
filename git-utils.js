let chalk = require("chalk");
let fs = require("fs");
const { exec } = require("child_process");

if (process.argv.length < 5) {
  console.log("git-auto-commit 命令:");
  console.log("$ npm run gac <type> <module> <message>\n");
  console.log("")
  console.log("git-auto-push 命令:(包含 gac 操作)");
  console.log("$ npm run gap <type> <module> <message>\n");
  return false;
}

let gitCmd = process.argv[2],
    type = process.argv[3],
    moduler = process.argv[4],
    message = process.argv.slice(5, process.argv.length).join(" "),
    version = null;

let execCommands = (commands) => {
  let object = commands.shift(),
    command = null,
    callback = null;

  if (typeof (object) == "object") {
    command = object.raw;
    callback = object.callback;
  } else {
    command = object;
  }

  command = renderCommand(command);
  exec(command, (error, stdout, stderr) => {
    console.log(chalk.gray("$ ") + chalk.yellow(command));
    console.log("");

    if (callback) callback(command, error, stdout, stderr);
    if (error) {
      console.error(chalk.red(error));
      process.exit(1);
    }
    if (stdout) console.log(chalk.gray(stdout));
    if (stderr) console.log(chalk.gray(stderr));

    if (commands.length) execCommands(commands);
  });
};

let renderCommand = (command) => {
  let variables = command.match(/\{\{(.*?)\}\}/g),
    text;

  if (!variables) return command;
  for (let i = 0, len = variables.length; i < len; i++) {
    variable = variables[i].replace(/\{|\}|\s/g, "");
    try {
      command = command.replace(variables[i], eval(variable));
    } catch (e) {
      console.log("命令模块: " + command);
      console.log("命令模块解析异常, 未变量: " + variable);
    }
  }
  return command;
};

/*
 * ./version.json commit 自动加1
 */
let autoIncrementCommitBy1 = () => {
  version = JSON.parse(fs.readFileSync("./version.json", "utf8"));

  console.error(chalk.yellow("commit " + version.commit + " => " + (parseInt(version.commit) + 1)));
  version.commit = parseInt(version.commit) + 1;
  version.pro_mini_version = [version.major, version.minor, version.tiny].join(".");
  version.pro_version = [[version.major, version.minor, version.tiny].join("."), version.commit].join("/");
  version.dev_version = [version.major, version.minor, version.commit].join(".");

  fs.writeFileSync("./version.json", JSON.stringify(version, null, 4), "utf-8");
  console.log(chalk.yellow(JSON.stringify(version, null, 4)));
};

/*
 * git status -s
 * 初始判断本地代码是否有调整
 */
let gitStatusCheckModified = (command, error, stdout, stderr) => {
  if (stdout && stdout.length) {
    console.log(chalk.gray(stdout));

    autoIncrementCommitBy1();
  } else {
    console.error(chalk.yellow("警告: 代码未调整，中止 git:auto:push 操作!"));
    process.exit(1);
  }
};

/*
 * git pull 时报错处理
 */
let gitPullCheckConflict = (command, error, stdout, stderr) => {
  if (error) {
    console.error(chalk.red(error));
    console.log(chalk.red("报错: 代码有冲突，请手工处理!"));
    process.exit(1);
  }
  if (stdout && stdout.length) {
    console.error(chalk.yellow(stdout));
  }
};

/*
 * git pull 后
 * git status -s 报错处理
 */
let gitStatusCheckConflict = (command, error, stdout, stderr) => {
  if (stdout && stdout.length) {
    console.log(chalk.red("报错: 代码有冲突，请手工处理!"));
    process.exit(1);
  }
};

/*
 * gac 操作流程:
 * 1. `git stsau -s` 代码无调整则中止操作, 否则 commit + 1
 * 2. `git add`
 * 3. `git commit`
 *
 * gap 操作流程:
 * 1. `git stsau -s` 代码无调整则中止操作, 否则 commit + 1
 * 2. `git add`
 * 3. `git commit`
 * 4. `git pull`
 * 5. `git status` 代码冲突则中止操作，提示人工处理
 * 6. `git push`
 */
commands = [
  { raw: "git status -s", callback: gitStatusCheckModified },
  "git add .",
  `git commit -m "${type}@{{version.pro_version}}(${moduler}): ${message}"`,
];

if(gitCmd === 'gap') {
  let gapCommands = [
    "git config --global core.mergeoptions --no-edit",
    { raw: "git pull", callback: gitPullCheckConflict },
    { raw: "git status -s", callback: gitStatusCheckConflict },
    "git push"
  ]
  commands = commands.concat(gapCommands)
}

execCommands(commands);
