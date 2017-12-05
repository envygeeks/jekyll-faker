[![Code Climate](https://img.shields.io/codeclimate/maintainability/anomaly/jekyll-faker.svg?style=for-the-badge)](https://codeclimate.com/github/anomaly/jekyll-faker/maintainability)
[![Code Climate](https://img.shields.io/codeclimate/coverage/github/anomaly/jekyll-faker.svg?style=for-the-badge)](https://codeclimate.com/github/anomaly/jekyll-faker/test_coverage)
[![Travis CI](https://img.shields.io/travis/anomaly/jekyll-faker/master.svg?style=for-the-badge)](https://travis-ci.org/anomaly/jekyll-faker)
![Gem Version](https://img.shields.io/gem/v/jekyll-faker.svg?style=for-the-badge)
![Gem DL](https://img.shields.io/gem/dt/jekyll-faker.svg?style=for-the-badge)

# Jekyll Faker

Jekyll Faker is a Jekyll/Liquid wrapper around the Faker gem, it allows you to do anything that Faker allows you to do, as long as it's an acceptable format. It is disaware of it's surroundings, and is extensible by automatic upgrade, meaning... if faker adds new methods, or even new classes, you can continue to use it without needing to upgrade Jekyll Faker.

## Example

Given faker has a class called `Lorem`, and that class `Lorem` accepts messages to the `sentences` method, you can do the following to extract the data from Faker:

```liquid
{% faker lorem sentences=8 %}
  <p>{{ faker.val }}</p>
{% endfaker %}
```

w/ the result

```html
<p>Sentence 1</p>
<p>Sentence 2</p>
<p>Sentence 3</p>
<p>Sentence 4</p>
<p>Sentence 5</p>
<p>Sentence 6</p>
<p>Sentence 7</p>
<p>Sentence 8</p>
```

### Multiple Arguments

If a class and method you wish to use takes multiple arguments, you can just replicate the method name, and we will ship those arguments into the method on your behalf.

```liquid
{% faker number between=1 between=10 %}
  <small>
    {{ faker.val }}
  </small>
{% endfaker %}
```

### CamelCase classes

If a Faker is a CamelCased class, for example "DrWho" (even though technically it's supposed to be DoctorWho, it's Doctor, not Dr, who even does that?) You can do the following:

```liquid
{% faker dr-who catch_phrase %}
  <p>{{ faker.val }}</p>
{% endfaker %}
```

or

```liquid
{% faker id-number valid %}
  <p>{{ faker.val }}</p>
{% endfaker %}
```
