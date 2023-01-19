
# RBR_UI_Tests

A personal project to test and practice Robot Framework test automation with Selenium.

Featuring tests for some of the everyday use cases pertaining to the Red Bull Racing website @ redbullracing.com, such as checking drivers information, verifying mailing list functionality, logging in to the paddock and so on.

## Demo



https://user-images.githubusercontent.com/77733793/213437495-f3302490-05fd-423f-9153-f854c9e946c1.mp4




## Authors

- [@jyriruohoniemi](https://www.github.com/jyriruohoniemi)


## Run Locally

Make sure you have installed Robot Framework

```pip
  pip install robotframework --user
```

Clone the project

```bash
  git clone https://github.com/jyriruohoniemi/RBR_UI_Tests
```

Go to the project directory

```bash
  cd my-project
```

Go to the tests folder

```bash
  cd tests
```

Run all tests

```bash
  python -m robot .
```
(Tests also have tagging included so to run only specific ones)

```bash
  python -m robot -include Primary/Secondary/Misc/Critical .
```
