import fs from "fs";

const solution = () => {
  fs.readFile(
    `${__dirname}/../../../subjects/day1/input`,
    "utf8",
    (err, data) => {
      if (err) {
        console.log(err);
        return;
      }
      const parsedInput = data.split("\n");

      let result = 0;

      parsedInput.reduce(
        (accumulator: number | undefined, currentValue: string) => {
          if (accumulator === undefined) {
            accumulator = 0;
          } else if (currentValue !== "") {
            accumulator += parseInt(currentValue);
          } else if (currentValue === "") {
            if (result < accumulator) {
              result = accumulator;
            }
            accumulator = 0;
          }
          return accumulator;
        },
        0
      );
      console.log(result);
    }
  );
};

export default { solution };
