const slice = [].slice
let number = 42
const opposite = true

if (opposite) {
  number = -42
}

console.info(number)

const square = function (xValue) {
  return xValue * xValue
}

const list = [1, 2, 3, 4, 5]

const math = {
  root: Math.sqrt,
  square: square,
  cube: function (xValue) {
    return xValue * square(xValue)
  },
}

const race = function () {
  const winner = arguments[0]
  const runners = arguments.length >= 2
    ? slice.call(arguments, 1)
    : []
  return print(winner, runners)
}

console.info(race)

const elvis = false

if (typeof elvis !== 'undefined' && elvis !== null) {
  alert('I knew it!')
}

const cubes = (() => {
  const results = []
  const len = list.length

  for (let index = 0; index < len; index++) {
    const num = list[index]
    results.push(math.cube(num))
  }
  return results
})()

console.info(cubes)
