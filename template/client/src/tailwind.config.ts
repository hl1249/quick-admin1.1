const fontSize = Object.fromEntries(
  Array.from({ length: 100 }, (_, index) => {
    const size = index + 1;
    return [size, `${size}rpx`];
  }),
);

const spacing = Object.fromEntries(
  Array.from({ length: 1001 }, (_, index) => [index, index === 0 ? "0" : `${index}rpx`]),
);

const config = {
  separator: "__",
  corePlugins: {
    preflight: false,
    space: false,
    divideWidth: false,
    divideColor: false,
    divideStyle: false,
    divideOpacity: false,
  },
  content: [
    "../index.html",
    "./App.vue",
    "./main.ts",
    "./components/**/*.{vue,js,ts}",
    "./pages/**/*.{vue,js,ts}",
    "./pagesAuth/**/*.{vue,js,ts}",
    "./pagesHome/**/*.{vue,js,ts}",
    "./pagesMine/**/*.{vue,js,ts}",
    "./pagesPublish/**/*.{vue,js,ts}",
    "./pagesEncyclopedia/**/*.{vue,js,ts}",
    "./pagesOther/**/*.{vue,js,ts}",
  ],
  theme: {
    fontSize,
    extend: {
      spacing,
      colors: {
        white: "#fff",
        black: "#000",
      },
      borderRadius: {
        4: "4rpx",
        6: "6rpx",
        8: "8rpx",
        10: "10rpx",
        12: "12rpx",
        16: "16rpx",
        20: "20rpx",
        24: "24rpx",
        28: "28rpx",
        32: "32rpx",
        36: "36rpx",
        40: "40rpx",
        42: "42rpx",
        44: "44rpx",
        46: "46rpx",
        48: "48rpx",
        50: "50rpx",
        full: "50%",
      },
      backgroundColor: {
        white: "#fff",
        black: "#000",
      },
    },
  },
  plugins: [],
};

export default config;