// https://github.com/sevenc-nanashi/nanacpp
#ifndef ONLINE_JUDGE
#define _GLIBCXX_DEBUG 1
#endif


// ----- features/core.hpp -----

#include <bits/stdc++.h>

#define fn auto
#define let auto

#define each(x, a) for (auto &x : a)
#define each1(x, a) for (auto &x : a)
#define each2(x, y, a) for (auto &[x, y] : a)
#define each3(x, y, z, a) for (auto &[x, y, z] : a)
#define each4(w, x, y, z, a) for (auto &[w, x, y, z] : a)

#define enumerate(x, i, a)                                                     \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &x = a[i]; true)
#define enumerate1(x, i, a)                                                    \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &x = a[i]; true)
#define enumerate2(x, y, i, a)                                                 \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &[x, y] = a[i]; true)
#define enumerate3(x, y, z, i, a)                                              \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &[x, y, z] = a[i]; true)
#define enumerate4(w, x, y, z, i, a)                                           \
  for (usize i = 0; i < (usize)a.size(); ++i)                                  \
    if (auto &[w, x, y, z] = a[i]; true)

#define rep(i, a) for (int i = 0; i < (a); ++i)
#define range(i, l, r) for (int i = (l); i < (r); ++i)
#define rangei(i, l, r) for (int i = (l); i <= (r); ++i)

#define chmax(var, val) (var) = std::max((var), (val))
#define chmin(var, val) (var) = std::min((var), (val))

#define all(x) std::begin(x), std::end(x)
#define rall(x) std::rbegin(x), std::rend(x)
#define sz(x) ((i64)(x).size())

using ll = long long;
using i8 = int8_t;
using i16 = int16_t;
using i32 = int32_t;
using i64 = int64_t;
using i128 = __int128;
using isize = std::make_signed<std::size_t>::type;
using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;
using u128 = __uint128_t;
using usize = std::make_unsigned<std::size_t>::type;
using f32 = float;
using f64 = double;

/// メモ：
/// Compareを(T a, T b) -> boolとしたとき、優先して取り出されるのは、Compare(a,
/// b)がtrueとなるbである。 つまり、Compareには「bを優先する条件」をいれる。
template <typename T, typename Compare = std::less<T>>
using PriorityQueue = std::priority_queue<T, std::vector<T>, Compare>;

char eol[] = "\n";

template <typename T> using Vec = std::vector<T>;

template <typename T> using Vec2 = std::vector<std::vector<T>>;

template <typename T> using Vec3 = std::vector<std::vector<std::vector<T>>>;

template <typename T, typename U> using OrderedMap = std::map<T, U>;

template <typename T, typename U> using Map = std::unordered_map<T, U>;

template <typename T> using OrderedSet = std::set<T>;

template <typename T> using Set = std::unordered_set<T>;

// ----- features/pair.hpp -----


/// `std::pair` のハッシュ対応版。
template <typename T, typename U> class hpair {
public:
  T first;
  U second;
  /// デフォルトコンストラクタ。
  hpair() = default;
  /// 値を受け取るコンストラクタ。
  hpair(const T &f, const U &s) : first(f), second(s) {}
  /// 等価比較。
  fn operator==(const hpair<T, U> &other) const->bool {
    return first == other.first && second == other.second;
  }
};

namespace std {
/// `hpair` を unordered 系コンテナで使うためのハッシュ。
template <typename T, typename U> struct hash<hpair<T, U>> {
  fn operator()(const hpair<T, U> &p) const->size_t {
    return hash<T>()(p.first) ^ (hash<U>()(p.second) << 1);
  }
};
} // namespace std

template <typename T, typename U> using Pair = hpair<T, U>;

// ----- features/input.hpp -----


/// 1 変数を読み込む。
#define input(type, var)                                                       \
  type var;                                                                    \
  std::cin >> var;

/// 要素数 `n` のベクタを読み込む。
#define input_vec(type, var, n)                                                \
  std::vector<type> var(n);                                                    \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    std::cin >> var[i];                                                        \
  }

/// 要素数 `n` のRArrayを読み込む。
#define input_rarray(type, var, n)                                             \
  RArray<type> var(n);                                                         \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    std::cin >> var[i];                                                        \
  }

/// 要素数固定の `std::array` を読み込む。
#define input_array(type, var, n)                                              \
  std::array<type, n> var;                                                     \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    std::cin >> var[i];                                                        \
  }

/// 2 要素の `std::pair` を読み込む。
#define input_pair(type1, type2, var)                                          \
  std::pair<type1, type2> var;                                                 \
  std::cin >> var.first >> var.second;

/// 2 要素の `hpair` を読み込む。
#define input_hpair(type1, type2, var)                                         \
  hpair<type1, type2> var;                                                     \
  std::cin >> var.first >> var.second;

/// 要素数 `n` の `std::pair` ベクタを読み込む。
#define input_vec_pair(type1, type2, var, n)                                   \
  std::vector<std::pair<type1, type2>> var(n);                                 \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    std::cin >> var[i].first >> var[i].second;                                 \
  }

/// 要素数 `n` の `hpair` ベクタを読み込む。
#define input_vec_hpair(type1, type2, var, n)                                  \
  std::vector<hpair<type1, type2>> var(n);                                     \
  for (usize i = 0; i < (usize)(n); ++i) {                                     \
    std::cin >> var[i].first >> var[i].second;                                 \
  }

/// 2 次元配列を読み込む。
#define input_vec2(type, var, rows, cols)                                      \
  std::vector<std::vector<type>> var(rows, std::vector<type>(cols));           \
  for (usize i = 0; i < (usize)(rows); ++i) {                                  \
    for (usize j = 0; j < (usize)(cols); ++j) {                                \
      std::cin >> var[i][j];                                                   \
    }                                                                          \
  }

/// 2 次元 RArray を読み込む。
#define input_rarray2(type, var, rows, cols)                                   \
  RArray<RArray<type>> var(rows, RArray<type>(cols));                          \
  for (usize i = 0; i < (usize)(rows); ++i) {                                  \
    for (usize j = 0; j < (usize)(cols); ++j) {                                \
      std::cin >> var[i][j];                                                   \
    }                                                                          \
  }

// ----- features/debug.hpp -----

#include <string>

/// `std::pair` を `(first, second)` 形式で出力する。
template <typename T, typename U>
fn operator<<(std::ostream &os, const std::pair<T, U> &p)->std::ostream & {
  os << "(" << p.first << ", " << p.second << ")";
  return os;
}

fn operator<<(std::ostream &os, const u128 &v)->std::ostream & {
  u128 temp = v;
  if (temp == 0) {
    os << '0';
    return os;
  }
  std::string digits;
  while (temp > 0) {
    digits.push_back(static_cast<char>('0' + (temp % 10)));
    temp /= 10;
  }
  std::reverse(digits.begin(), digits.end());
  os << digits;
  return os;
}

fn operator<<(std::ostream &os, const i128 &v)->std::ostream & {
  if (v >= 0) {
    return os << static_cast<u128>(v);
  } else {
    os << '-';
    return os << static_cast<u128>(-v);
  }
}

/// `std::vector` を可読なリスト形式で出力する。
template <typename T>
fn operator<<(std::ostream &os, const std::vector<T> &v)->std::ostream & {
  os << "[";
  for (usize i = 0; i < v.size(); ++i) {
    os << v[i];
    if (i + 1 != v.size()) {
      os << ", ";
    }
  }
  os << "]";
  return os;
}

/// `std::set` を空白区切りで出力する。
template <typename T>
fn operator<<(std::ostream &os, const std::set<T> &v)->std::ostream & {
  os << "{";
  for (auto it = v.begin(); it != v.end(); ++it) {
    os << *it;
    auto next_it = it;
    ++next_it;
    if (next_it != v.end()) {
      os << " ";
    }
  }
  os << "}";
  return os;
}

/// `std::unordered_set` を空白区切りで出力する。
template <typename T>
fn operator<<(std::ostream &os, const std::unordered_set<T> &v)
    ->std::ostream & {
  os << "{";
  for (auto it = v.begin(); it != v.end(); ++it) {
    os << *it;
    auto next_it = it;
    ++next_it;
    if (next_it != v.end()) {
      os << " ";
    }
  }
  os << "}";
  return os;
}

/// `std::map` を `key: value` の並びで出力する。
template <typename T, typename U>
fn operator<<(std::ostream &os, const std::map<T, U> &m)->std::ostream & {
  os << "{";
  for (auto it = m.begin(); it != m.end(); ++it) {
    os << it->first << ": " << it->second;
    auto next_it = it;
    ++next_it;
    if (next_it != m.end()) {
      os << ", ";
    }
  }
  os << "}";
  return os;
}

/// `std::unordered_map` を `key: value` の並びで出力する。
template <typename T, typename U>
fn operator<<(std::ostream &os, const std::unordered_map<T, U> &m)
    ->std::ostream & {
  os << "{";
  for (auto it = m.begin(); it != m.end(); ++it) {
    os << it->first << ": " << it->second;
    auto next_it = it;
    ++next_it;
    if (next_it != m.end()) {
      os << ", ";
    }
  }
  os << "}";
  return os;
}

/// ローカル実行時のみ変数を stderr に出力し、値をそのまま返すデバッグマクロ群。
#ifdef ONLINE_JUDGE
#define dbg(x) x
#define dbg2(x) x
#define dbg3(x) x
#else
#define dbg(x)                                                                 \
  ([&]() {                                                                     \
    auto _dbg_x = (x);                                                         \
    std::cerr << "[dbg L" << __LINE__ << "] " << #x << " = ";                  \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#define dbg2(x)                                                                \
  ([&]() {                                                                     \
    auto _dbg_x = (x);                                                         \
    std::cerr << "[[dbg L" << __LINE__ << "]] " << #x << " = ";                \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#define dbg3(x)                                                                \
  ([&]() {                                                                     \
    auto _dbg_x = (x);                                                         \
    std::cerr << "[[[dbg L" << __LINE__ << "]]] " << #x << " = ";              \
    std::cerr << _dbg_x << std::endl;                                          \
    return _dbg_x;                                                             \
  }())
#endif

// ----- features/array_sum.hpp -----


/// 1 次元配列の累積和を保持し、区間和を高速に計算するヘルパー。
template <typename T> class ArraySum {
private:
  usize n;
  std::vector<T> prefix_sum;

public:
  /// `data` から累積和を構築する。計算量は O(N)。
  explicit ArraySum(const std::vector<T> &data)
      : n(data.size()), prefix_sum(n + 1, 0) {
    for (usize i = 0; i < n; ++i) {
      prefix_sum[i + 1] = prefix_sum[i] + data[i];
    }
  }

  /// 区間 [l, r) の和を返す
  fn sum(size_t l, size_t r) const -> T {
    return prefix_sum[r] - prefix_sum[l];
  }

  /// 区間 [l, r] の和を返す
  fn sum_closed(size_t l, size_t r) const -> T {
    return prefix_sum[r + 1] - prefix_sum[l];
  }
};

// ----- features/bisect.hpp -----


template <typename F>
/// 半開区間 `[l, r)` で `cond(i)` が真になる最初の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
fn bisect_first(i64 l, i64 r, F &&cond) -> std::optional<i64> {
  if (cond(l)) {
    return l;
  }
  if (!cond(r - 1)) {
    return std::nullopt;
  }

  i64 left = l - 1;
  i64 right = r;
  while (left + 1 < right) {
    i64 mid = left + (right - left) / 2;
    if (cond(mid)) {
      right = mid;
    } else {
      left = mid;
    }
  }
  return right;
}

template <typename F>
/// 閉区間 `[l, r]` で `cond(i)` が真になる最初の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
fn bisect_first_closed(i64 l, i64 r, F &&cond) -> std::optional<i64> {
  return bisect_first(l, r + 1, cond);
}

template <typename F>
/// 半開区間 `[l, r)` で `cond(i)` が真になる最後の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
fn bisect_last(i64 l, i64 r, F &&cond) -> std::optional<i64> {
  if (!cond(l)) {
    return std::nullopt;
  }
  if (cond(r - 1)) {
    return r - 1;
  }

  i64 left = l;
  i64 right = r;
  while (left + 1 < right) {
    i64 mid = left + (right - left) / 2;
    if (cond(mid)) {
      left = mid;
    } else {
      right = mid;
    }
  }
  return left;
}

template <typename F>
/// 閉区間 `[l, r]` で `cond(i)` が真になる最後の `i` を返す。
/// 存在しなければ `std::nullopt` を返す。
fn bisect_last_closed(i64 l, i64 r, F &&cond) -> std::optional<i64> {
  return bisect_last(l, r + 1, cond);
}

// ----- features/imos.hpp -----


/// Imos 法（差分配列）で区間加算をまとめて反映するユーティリティ。
template <typename T> class Imos {
private:
  std::vector<T> diff;
  std::vector<T> built_values;
  bool ready;

public:
  /// 要素数 `n` の差分配列を初期化する。
  explicit Imos(usize n) : diff(n + 1, 0), built_values(n, 0), ready(false) {}

  /// 配列の長さを返す。
  fn size() const -> usize { return built_values.size(); }

  /// 区間 [l, r) に `value` を加算する。
  fn add(usize l, usize r, const T &value) -> void {
    assert(l <= r);
    assert(l <= size());
    assert(r <= size());
    diff[l] += value;
    diff[r] -= value;
    ready = false;
  }

  /// 区間 [l, r] に `value` を加算する。
  fn add_closed(usize l, usize r, const T &value) -> void {
    assert(l <= r);
    assert(r < size());
    add(l, r + 1, value);
  }

  /// 累積して最終的な配列を構築し、参照を返す。複数回呼ぶと結果をキャッシュする。
  [[nodiscard]] fn build() -> const std::vector<T> & {
    if (!ready) {
      T run = 0;
      for (usize i = 0; i < size(); ++i) {
        run += diff[i];
        built_values[i] = run;
      }
      ready = true;
    }
    return built_values;
  }

  /// 構築済みの値を取得する。`build` を事前に呼ぶ必要がある。
  [[nodiscard]] fn values() const -> const std::vector<T> & {
    assert(ready);
    return built_values;
  }

  /// 構築済みの値へのランダムアクセス。`build` を事前に呼ぶ必要がある。
  [[nodiscard]] fn operator[](usize idx) const->const T & {
    assert(ready);
    return built_values[idx];
  }

  /// 基底配列に差分を適用した新しい配列を返す。
  fn applied(std::vector<T> base) -> std::vector<T> {
    assert(base.size() == size());
    const auto &delta = build();
    for (usize i = 0; i < size(); ++i) {
      base[i] += delta[i];
    }
    return base;
  }
};

// ----- features/prime.hpp -----


/// エラトステネスの篩を用いた素数判定・素因数分解ユーティリティ。
class PrimeSieve {
private:
  int limit;
  std::vector<int> primes_vec;
  std::vector<int> least_prime;

  fn build() -> void {
    if (limit >= 0)
      least_prime[0] = 0;
    if (limit >= 1)
      least_prime[1] = 1;

    for (int i = 2; i <= limit; ++i) {
      if (least_prime[i] == 0) {
        least_prime[i] = i;
        primes_vec.push_back(i);
      }
      for (int p : primes_vec) {
        if (p > least_prime[i])
          break;
        ll mul = 1LL * i * p;
        if (mul > limit)
          break;
        least_prime[mul] = p;
      }
    }
  }

public:
  /// `n` 以下の整数を対象に篩を構築する。
  explicit PrimeSieve(int n) : limit(n), primes_vec(), least_prime(n + 1, 0) {
    assert(limit >= 0);
    build();
  }

  PrimeSieve(const PrimeSieve &) = delete;
  PrimeSieve &operator=(const PrimeSieve &) = delete;
  PrimeSieve(PrimeSieve &&) = default;
  PrimeSieve &operator=(PrimeSieve &&) = default;

  /// 篩の最大値（構築時の `n`）を返す。
  fn max_n() const -> int { return limit; }

  /// `n` 以下の素数リストを返す。
  fn primes() const -> const std::vector<int> & { return primes_vec; }

  /// `n` が素数か判定する。
  fn is_prime(int n) const -> bool {
    assert(0 <= n && n <= limit);
    return n >= 2 && least_prime[n] == n;
  }

  /// `n` の最小素因数を返す。
  fn least_factor(int n) const -> int {
    assert(1 <= n && n <= limit);
    return least_prime[n];
  }

  /// `n`（`n <= limit`）を素因数分解し、素因数と指数の組を返す。
  fn factorize_bounded(int n) const -> std::vector<std::pair<int, int>> {
    assert(1 <= n && n <= limit);
    std::vector<std::pair<int, int>> factors;
    while (n > 1) {
      int p = least_prime[n];
      int cnt = 0;
      while (n % p == 0) {
        n /= p;
        ++cnt;
      }
      factors.push_back({p, cnt});
    }
    return factors;
  }

  /// `n` を素因数分解する（`n <= limit^2` が前提）。
  fn factorize(ll n) const -> std::vector<std::pair<ll, int>> {
    assert(n >= 1);
    assert(1LL * limit * limit >= n);
    std::vector<std::pair<ll, int>> factors;
    ll cur = n;
    for (int p : primes_vec) {
      if (1LL * p * p > cur)
        break;
      if (cur % p != 0)
        continue;
      int cnt = 0;
      while (cur % p == 0) {
        cur /= p;
        ++cnt;
      }
      factors.push_back({p, cnt});
    }
    if (cur > 1) {
      factors.push_back({cur, 1});
    }
    return factors;
  }
};

// ----- features/tally.hpp -----


/// ベクタ内の要素頻度を `std::map` で数える。
template <typename T> fn tally(const std::vector<T> &data) -> std::map<T, u64> {
  std::map<T, u64> counts;
  for (const auto &item : data) {
    counts[item]++;
  }
  return counts;
}

// ----- features/cumulative_sum_2d.hpp -----


/// 2 次元配列の累積和を保持し、長方形領域の総和を O(1) で取得するクラス。
template <typename T> class CumulativeSum2D {
private:
  usize height;
  usize width;
  std::vector<std::vector<T>> prefix;

public:
  /// `grid` の累積和を構築する。行ごとの幅が一致していることを前提とする。
  explicit CumulativeSum2D(const std::vector<std::vector<T>> &grid)
      : height(grid.size()), width(height ? grid[0].size() : 0),
        prefix(height + 1, std::vector<T>(width + 1, 0)) {
    for (usize y = 0; y < height; ++y) {
      assert(grid[y].size() == width);
      for (usize x = 0; x < width; ++x) {
        prefix[y + 1][x + 1] =
            grid[y][x] + prefix[y][x + 1] + prefix[y + 1][x] - prefix[y][x];
      }
    }
  }

  /// 行数を返す。
  fn rows() const -> usize { return height; }

  /// 列数を返す。
  fn cols() const -> usize { return width; }

  /// 長方形 [top, bottom) × [left, right) の和を返す。
  fn sum(usize top, usize left, usize bottom, usize right) const -> T {
    assert(top <= bottom);
    assert(left <= right);
    assert(bottom <= height);
    assert(right <= width);
    return prefix[bottom][right] - prefix[top][right] - prefix[bottom][left] +
           prefix[top][left];
  }

  /// 長方形 [top, bottom] × [left, right] の和を返す。
  fn sum_closed(usize top, usize left, usize bottom, usize right) const -> T {
    assert(bottom < height);
    assert(right < width);
    return sum(top, left, bottom + 1, right + 1);
  }
};

// ----- features/imos_2d.hpp -----


/// 2 次元 Imos 法（差分配列）で長方形加算をまとめて反映するユーティリティ。
template <typename T> class Imos2D {
private:
  usize height;
  usize width;
  std::vector<std::vector<T>> diff;
  std::vector<std::vector<T>> built_values;
  bool ready;

public:
  /// 高さ `h`、幅 `w` の差分配列を初期化する。
  Imos2D(usize h, usize w)
      : height(h), width(w), diff(h + 1, std::vector<T>(w + 1, 0)),
        built_values(h, std::vector<T>(w, 0)), ready(false) {}

  /// 行数を返す。
  fn rows() const -> usize { return height; }

  /// 列数を返す。
  fn cols() const -> usize { return width; }

  /// 長方形 [top, bottom) × [left, right) に `value` を加算する。
  fn add(usize top, usize left, usize bottom, usize right, const T &value)
      -> void {
    assert(top <= bottom);
    assert(left <= right);
    assert(bottom <= height);
    assert(right <= width);
    diff[top][left] += value;
    diff[bottom][left] -= value;
    diff[top][right] -= value;
    diff[bottom][right] += value;
    ready = false;
  }

  /// 長方形 [top, bottom] × [left, right] に `value` を加算する。
  fn add_closed(usize top, usize left, usize bottom, usize right,
                const T &value) -> void {
    assert(bottom < height);
    assert(right < width);
    add(top, left, bottom + 1, right + 1, value);
  }

  /// 累積して最終的な 2
  /// 次元配列を構築し、参照を返す。複数回呼ぶと結果をキャッシュする。
  [[nodiscard]] fn build() -> const std::vector<std::vector<T>> & {
    if (!ready) {
      std::vector<std::vector<T>> acc(height + 1, std::vector<T>(width + 1, 0));
      for (usize y = 0; y <= height; ++y) {
        for (usize x = 0; x <= width; ++x) {
          T val = diff[y][x];
          if (y > 0) {
            val += acc[y - 1][x];
          }
          if (x > 0) {
            val += acc[y][x - 1];
          }
          if (y > 0 && x > 0) {
            val -= acc[y - 1][x - 1];
          }
          acc[y][x] = val;
          if (y < height && x < width) {
            built_values[y][x] = val;
          }
        }
      }
      ready = true;
    }
    return built_values;
  }

  /// 構築済みの値を取得する。`build` を事前に呼ぶ必要がある。
  [[nodiscard]] fn values() const -> const std::vector<std::vector<T>> & {
    assert(ready);
    return built_values;
  }

  /// 構築済みの値への行アクセス。`build` を事前に呼ぶ必要がある。
  fn operator[](usize row) const->const std::vector<T> & {
    assert(ready);
    return built_values[row];
  }

  /// 基底の 2 次元配列に差分を適用した新しい配列を返す。
  fn applied(std::vector<std::vector<T>> base) -> std::vector<std::vector<T>> {
    assert(base.size() == height);
    for (const auto &row : base) {
      assert(row.size() == width);
    }
    const auto &delta = build();
    for (usize y = 0; y < height; ++y) {
      for (usize x = 0; x < width; ++x) {
        base[y][x] += delta[y][x];
      }
    }
    return base;
  }
};

// ----- features/interval_set.hpp -----


/// 区間の和集合を `std::set` で管理するデータ構造。
template <typename T> class IntervalSet {
private:
  std::set<std::pair<T, T>> segs;

public:
  IntervalSet() = default;

  /// 現在保持している非交差の区間集合への参照を返す。
  fn intervals() const -> const std::set<std::pair<T, T>> & { return segs; }

  /// 点 `x` を含む区間を返す。存在しない場合は `std::nullopt`。
  fn find(T x) const -> std::optional<std::pair<T, T>> {
    auto it = segs.upper_bound({x, std::numeric_limits<T>::max()});
    if (it == segs.begin()) {
      return std::nullopt;
    }
    --it;
    if (it->first <= x && x < it->second) {
      return *it;
    }
    return std::nullopt;
  }

  /// 半開区間 `[l, r)` を追加し、新たに被覆された長さを返す。
  /// `l >= r` の場合は何もせず 0 を返す。
  fn add(T l, T r) -> T {
    if (l >= r) {
      return static_cast<T>(0);
    }

    T added = r - l;
    auto it = segs.lower_bound({l, l});
    if (it != segs.begin()) {
      auto prev = std::prev(it);
      if (prev->second >= l) {
        it = prev;
      }
    }

    std::vector<typename std::set<std::pair<T, T>>::iterator> erase_list;
    T nl = l;
    T nr = r;

    for (; it != segs.end() && it->first <= nr; ++it) {
      nl = std::min(nl, it->first);
      nr = std::max(nr, it->second);

      T left = std::max(l, it->first);
      T right = std::min(r, it->second);
      if (left < right) {
        added -= right - left;
      }
      erase_list.push_back(it);
    }

    for (auto e : erase_list) {
      segs.erase(e);
    }
    segs.emplace(nl, nr);
    return added;
  }

  /// 半開区間 `[l, r)` を削除し、減少した被覆長を返す。
  /// `l >= r` の場合は何もせず 0 を返す。
  fn remove(T l, T r) -> T {
    if (l >= r) {
      return static_cast<T>(0);
    }

    auto it = segs.lower_bound({l, l});
    if (it != segs.begin()) {
      auto prev = std::prev(it);
      if (prev->second > l) {
        it = prev;
      }
    }

    std::vector<std::pair<T, T>> add_back;
    std::vector<typename std::set<std::pair<T, T>>::iterator> erase_list;
    T removed = 0;

    for (; it != segs.end() && it->first < r; ++it) {
      auto [il, ir] = *it;
      if (ir <= l) {
        continue;
      }

      T left = std::max(l, il);
      T right = std::min(r, ir);
      if (left >= right) {
        continue;
      }

      removed += right - left;
      if (il < left) {
        add_back.emplace_back(il, left);
      }
      if (right < ir) {
        add_back.emplace_back(right, ir);
      }
      erase_list.push_back(it);
    }

    for (auto e : erase_list) {
      segs.erase(e);
    }
    for (auto [il, ir] : add_back) {
      segs.emplace(il, ir);
    }
    return removed;
  }
};

// ----- features/vec_map.hpp -----


/// コンテナ内の要素に対してFを適用したものを返す。
template <typename T, typename F, typename V>
fn vec_map(const V &vec, F &&func) -> std::vector<T> {
  std::vector<T> result;
  result.reserve(sz(vec));
  each(x, vec) { result.push_back(func(x)); }
  return result;
}

/// コンテナ内の要素をFによって変換する。
template <typename F, typename V> fn vec_map_inplace(V &vec, F &&func) -> void {
  each(x, vec) { x = func(x); }
}

// ----- features/sort_by.hpp -----


/// コンテナを selector の結果で昇順ソートする。
template <typename V, typename F> fn sort_by(V &vec, F &&selector) -> void {
  std::sort(all(vec), [&](const auto &a, const auto &b) {
    return std::invoke(selector, a) < std::invoke(selector, b);
  });
}

/// コンテナを selector の結果で降順ソートする。
template <typename V, typename F>
fn sort_by_desc(V &vec, F &&selector) -> void {
  std::sort(all(vec), [&](const auto &a, const auto &b) {
    return std::invoke(selector, a) > std::invoke(selector, b);
  });
}

// ----- features/key_packer.hpp -----


/// 複数の非負整数を、各値の最大値に基づいて1つの整数キーへ変換する。
template <typename T = i64> class KeyPacker {
private:
  std::vector<T> maxes;

public:
  explicit KeyPacker(const std::vector<T> &maxes) : maxes(maxes) {
    each(max, this->maxes) {
      if (max < 0) {
        throw std::invalid_argument("max must be non-negative");
      }
    }
  }

  KeyPacker(std::initializer_list<T> maxes)
      : KeyPacker(std::vector<T>(maxes)) {}

  /// 各次元の最大値への参照を返す。
  fn limits() const -> const std::vector<T> & { return maxes; }

  /// 値列が各次元の範囲内に収まるかを返す。
  fn within_range(const std::vector<T> &values) const -> bool {
    if (values.size() != maxes.size()) {
      throw std::invalid_argument(
          "number of values must match number of maxes");
    }

    enumerate(value, i, values) {
      const T max = maxes[i];
      if (value < 0 || value > max) {
        return false;
      }
    }
    return true;
  }

  fn within_range(std::initializer_list<T> values) const -> bool {
    return within_range(std::vector<T>(values));
  }

  template <typename... Args> fn within_range(Args... values) const -> bool {
    return within_range(std::vector<T>{static_cast<T>(values)...});
  }

  /// 値列を1つの整数キーに変換する。
  fn pack(const std::vector<T> &values) const -> T {
    if (values.size() != maxes.size()) {
      throw std::invalid_argument(
          "number of values must match number of maxes");
    }

    T key = 0;
    T multiplier = 1;
    enumerate(value, i, values) {
      const T max = maxes[i];
      if (value < 0 || value > max) {
        throw std::invalid_argument("value exceeds max");
      }

      key += value * multiplier;
      multiplier *= max + 1;
    }
    return key;
  }

  fn pack(std::initializer_list<T> values) const -> T {
    return pack(std::vector<T>(values));
  }

  template <typename... Args> fn pack(Args... values) const -> T {
    return pack(std::vector<T>{static_cast<T>(values)...});
  }

  /// 整数キーを元の値列に戻す。
  fn unpack(T key) const -> std::vector<T> {
    if (key < 0) {
      throw std::invalid_argument("key must be non-negative");
    }

    std::vector<T> values;
    values.reserve(maxes.size());

    T multiplier = 1;
    each(max, maxes) {
      values.push_back((key / multiplier) % (max + 1));
      multiplier *= max + 1;
    }
    return values;
  }
};

// ----- features/rarray.hpp -----


#if __cplusplus >= 202002L
#include <source_location>
#define NANACPP_RARRAY_HAS_SOURCE_LOCATION 1
#else
#define NANACPP_RARRAY_HAS_SOURCE_LOCATION 0
#endif

/// Ruby風の配列。
template <typename T, typename Allocator = std::allocator<T>>
class RArray : public std::vector<T, Allocator> {
private:
  using Base = std::vector<T, Allocator>;

#if NANACPP_RARRAY_HAS_SOURCE_LOCATION
  template <typename Index>
  [[noreturn]] static fn
  throw_out_of_range(Index index, typename Base::size_type size,
                     const std::source_location &location) -> void {
    std::ostringstream oss;
    oss << "RArray index out of range: index=" << index << ", size=" << size
        << ", called from " << location.file_name() << ":" << location.line()
        << ":" << location.column() << " in " << location.function_name();
    throw std::out_of_range(oss.str());
  }
#else
  template <typename Index>
  [[noreturn]] static fn throw_out_of_range(Index index,
                                            typename Base::size_type size)
      -> void {
    std::ostringstream oss;
    oss << "RArray index out of range: index=" << index << ", size=" << size;
    throw std::out_of_range(oss.str());
  }
#endif

  template <typename Index>
  static fn normalize_index(Index index, typename Base::size_type size) ->
      typename Base::size_type {
    using difference_type = typename Base::difference_type;
    const difference_type signed_size = static_cast<difference_type>(size);
    const difference_type signed_index = static_cast<difference_type>(index);
    const difference_type normalized_index =
        signed_index < 0 ? signed_size + signed_index : signed_index;
    return static_cast<typename Base::size_type>(normalized_index);
  }

  template <typename Range>
  using RangeLike = std::void_t<decltype(std::declval<Range>().first()),
                                decltype(std::declval<Range>().last()),
                                decltype(std::declval<Range>().exclude_last())>;

  template <typename U>
  using Comparable =
      std::void_t<decltype(std::declval<U>() < std::declval<U>())>;

  template <typename U>
  using Numeric = std::enable_if_t<std::is_arithmetic<U>::value>;

#if NANACPP_RARRAY_HAS_SOURCE_LOCATION
  template <typename Range>
  fn slice_by_range(const Range &range,
                    const std::source_location &location) const -> RArray {
    if (range.empty()) {
      return RArray();
    }

    const size_type first_index = normalize_index(range.first(), this->size());
    const size_type last_index = normalize_index(range.last(), this->size());
    const size_type end_index =
        range.exclude_last() ? last_index : last_index + 1;
#ifndef ONLINE_JUDGE
    if (first_index >= this->size()) {
      throw_out_of_range(range.first(), this->size(), location);
    }
    if (end_index > this->size()) {
      throw_out_of_range(range.last(), this->size(), location);
    }
#endif
    if (first_index >= end_index) {
      return RArray();
    }
    return RArray(this->begin() + first_index, this->begin() + end_index);
  }
#else
  template <typename Range>
  fn slice_by_range(const Range &range) const -> RArray {
    if (range.empty()) {
      return RArray();
    }

    const size_type first_index = normalize_index(range.first(), this->size());
    const size_type last_index = normalize_index(range.last(), this->size());
    const size_type end_index =
        range.exclude_last() ? last_index : last_index + 1;
#ifndef ONLINE_JUDGE
    if (first_index >= this->size()) {
      throw_out_of_range(range.first(), this->size());
    }
    if (end_index > this->size()) {
      throw_out_of_range(range.last(), this->size());
    }
#endif
    if (first_index >= end_index) {
      return RArray();
    }
    return RArray(this->begin() + first_index, this->begin() + end_index);
  }
#endif

public:
  using typename Base::allocator_type;
  using typename Base::const_reference;
  using typename Base::reference;
  using typename Base::size_type;
  using typename Base::value_type;

  using Base::Base;

#if NANACPP_RARRAY_HAS_SOURCE_LOCATION
  fn operator[](size_type index,
                std::source_location location = std::source_location::current())
      ->reference {
#ifndef ONLINE_JUDGE
    if (index >= this->size()) {
      throw_out_of_range(index, this->size(), location);
    }
#endif
    return Base::operator[](index);
  }

  fn operator[](size_type index,
                std::source_location location =
                    std::source_location::current()) const->const_reference {
#ifndef ONLINE_JUDGE
    if (index >= this->size()) {
      throw_out_of_range(index, this->size(), location);
    }
#endif
    return Base::operator[](index);
  }

  template <typename Index,
            typename = std::enable_if_t<std::is_signed_v<Index>>>
  fn operator[](Index index,
                std::source_location location = std::source_location::current())
      ->reference {
    const size_type normalized_index = normalize_index(index, this->size());
#ifndef ONLINE_JUDGE
    if (normalized_index >= this->size()) {
      throw_out_of_range(index, this->size(), location);
    }
#endif
    return Base::operator[](normalized_index);
  }

  template <typename Index,
            typename = std::enable_if_t<std::is_signed_v<Index>>>
  fn operator[](Index index,
                std::source_location location =
                    std::source_location::current()) const->const_reference {
    const size_type normalized_index = normalize_index(index, this->size());
#ifndef ONLINE_JUDGE
    if (normalized_index >= this->size()) {
      throw_out_of_range(index, this->size(), location);
    }
#endif
    return Base::operator[](normalized_index);
  }

  template <typename Range, typename = RangeLike<Range>>
  fn operator[](const Range &range,
                std::source_location location =
                    std::source_location::current()) const->RArray {
    return slice_by_range(range, location);
  }
#else
  fn operator[](size_type index)->reference {
#ifndef ONLINE_JUDGE
    if (index >= this->size()) {
      throw_out_of_range(index, this->size());
    }
#endif
    return Base::operator[](index);
  }

  fn operator[](size_type index) const->const_reference {
#ifndef ONLINE_JUDGE
    if (index >= this->size()) {
      throw_out_of_range(index, this->size());
    }
#endif
    return Base::operator[](index);
  }

  template <typename Index,
            typename = std::enable_if_t<std::is_signed<Index>::value>>
  fn operator[](Index index)->reference {
    const size_type normalized_index = normalize_index(index, this->size());
#ifndef ONLINE_JUDGE
    if (normalized_index >= this->size()) {
      throw_out_of_range(index, this->size());
    }
#endif
    return Base::operator[](normalized_index);
  }

  template <typename Index,
            typename = std::enable_if_t<std::is_signed<Index>::value>>
  fn operator[](Index index) const->const_reference {
    const size_type normalized_index = normalize_index(index, this->size());
#ifndef ONLINE_JUDGE
    if (normalized_index >= this->size()) {
      throw_out_of_range(index, this->size());
    }
#endif
    return Base::operator[](normalized_index);
  }

  template <typename Range, typename = RangeLike<Range>>
  fn operator[](const Range &range) const->RArray {
    return slice_by_range(range);
  }
#endif

  fn first() const -> std::optional<T> {
    if (this->empty()) {
      return std::nullopt;
    }
    return Base::front();
  }

  fn last() const -> std::optional<T> {
    if (this->empty()) {
      return std::nullopt;
    }
    return Base::back();
  }

  fn include(const T &value) const -> bool {
    return std::find(this->begin(), this->end(), value) != this->end();
  }

  fn count(const T &value) const -> size_type {
    return static_cast<size_type>(
        std::count(this->begin(), this->end(), value));
  }

  fn take(size_type count) const -> RArray {
    const size_type take_count = std::min(count, this->size());
    return RArray(this->begin(), this->begin() + take_count);
  }

  fn drop(size_type count) const -> RArray {
    const size_type drop_count = std::min(count, this->size());
    return RArray(this->begin() + drop_count, this->end());
  }

  fn reverse() const -> RArray {
    RArray result(this->rbegin(), this->rend());
    return result;
  }

  fn sort() const -> RArray {
    RArray result = *this;
    result.sort_inplace();
    return result;
  }

  fn sort_inplace() -> void { std::sort(this->begin(), this->end()); }

  fn sort_desc() const -> RArray {
    RArray result = *this;
    result.sort_desc_inplace();
    return result;
  }

  fn sort_desc_inplace() -> void {
    std::sort(this->begin(), this->end(), std::greater<T>());
  }

  template <typename F> fn sort_by(F &&selector) const -> RArray {
    RArray result = *this;
    result.sort_by_inplace(std::forward<F>(selector));
    return result;
  }

  template <typename F> fn sort_by_inplace(F &&selector) -> void {
    std::sort(this->begin(), this->end(), [&](const auto &a, const auto &b) {
      return std::invoke(selector, a) < std::invoke(selector, b);
    });
  }

  template <typename F> fn sort_by_desc(F &&selector) const -> RArray {
    RArray result = *this;
    result.sort_by_desc_inplace(std::forward<F>(selector));
    return result;
  }

  template <typename F> fn sort_by_desc_inplace(F &&selector) -> void {
    std::sort(this->begin(), this->end(), [&](const auto &a, const auto &b) {
      return std::invoke(selector, a) > std::invoke(selector, b);
    });
  }

  fn dup() const -> RArray { return RArray(this->begin(), this->end()); }

  fn tally() const -> Map<T, size_type> {
    Map<T, size_type> counts;
    for (const auto &value : *this) {
      ++counts[value];
    }
    return counts;
  }

  fn to_vec() const -> std::vector<T> {
    return std::vector<T>(this->begin(), this->end());
  }
  fn into_vec() && -> std::vector<T> {
    return std::vector<T>(std::make_move_iterator(this->begin()),
                          std::make_move_iterator(this->end()));
  }

  template <typename U = T, typename = Comparable<U>>
  fn min() const -> std::optional<T> {
    if (this->empty()) {
      return std::nullopt;
    }
    return *std::min_element(this->begin(), this->end());
  }

  template <typename U = T, typename = Comparable<U>>
  fn max() const -> std::optional<T> {
    if (this->empty()) {
      return std::nullopt;
    }
    return *std::max_element(this->begin(), this->end());
  }

  template <typename U = T, typename = Comparable<U>>
  fn minmax() const -> std::optional<std::pair<T, T>> {
    if (this->empty()) {
      return std::nullopt;
    }
    const auto [min_it, max_it] =
        std::minmax_element(this->begin(), this->end());
    return std::pair<T, T>{*min_it, *max_it};
  }

  template <typename U = T, typename = Numeric<U>> fn sum() const -> T {
    return std::accumulate(this->begin(), this->end(), static_cast<T>(0));
  }

  template <typename U = T, typename = Numeric<U>> fn product() const -> T {
    return std::accumulate(this->begin(), this->end(), static_cast<T>(1),
                           std::multiplies<T>());
  }
};

template <typename T>
fn operator<<(std::ostream &os, const RArray<T> &v)->std::ostream & {
  os << "[";
  for (usize i = 0; i < v.size(); ++i) {
    os << v[i];
    if (i + 1 != v.size()) {
      os << ", ";
    }
  }
  os << "]";
  return os;
}

template <typename T> using RArray2 = RArray<RArray<T>>;
template <typename T> using RArray3 = RArray<RArray<RArray<T>>>;

// ----- features/rrange.hpp -----


/// Ruby風の整数Range。
template <typename T> class RRange {
  static_assert(std::is_integral_v<T>, "RRange requires an integral type");

private:
  T first_value;
  T last_value;
  bool exclude_last_value;

  class Iterator {
  private:
    T value;

  public:
    using difference_type = std::ptrdiff_t;
    using value_type = T;

    explicit Iterator(T value) : value(value) {}

    fn operator*() const->T { return value; }

    fn operator++()->Iterator & {
      ++value;
      return *this;
    }
  };

  class Sentinel {
  private:
    T last_value;
    bool exclude_last_value;

  public:
    Sentinel(T last_value, bool exclude_last_value)
        : last_value(last_value), exclude_last_value(exclude_last_value) {}

    friend fn operator!=(const Iterator &it, const Sentinel &sentinel)->bool {
      if (sentinel.exclude_last_value) {
        return *it < sentinel.last_value;
      }
      return *it <= sentinel.last_value;
    }
  };

public:
  RRange(T first, T last, bool exclude_last = false)
      : first_value(first), last_value(last), exclude_last_value(exclude_last) {
  }

  static fn inclusive(T first, T last) -> RRange { return RRange(first, last); }

  static fn exclusive(T first, T last) -> RRange {
    return RRange(first, last, true);
  }

  fn first() const -> T { return first_value; }

  fn last() const -> T { return last_value; }

  fn exclude_last() const -> bool { return exclude_last_value; }

  fn empty() const -> bool {
    if (first_value > last_value) {
      return true;
    }
    return exclude_last_value && first_value == last_value;
  }

  fn include(T value) const -> bool {
    if (value < first_value) {
      return false;
    }
    if (exclude_last_value) {
      return value < last_value;
    }
    return value <= last_value;
  }

  fn overlaps(const RRange &other) const -> bool {
    if (empty() || other.empty()) {
      return false;
    }
    return !(last_value < other.first_value ||
             (exclude_last_value && last_value == other.first_value) ||
             (other.exclude_last_value && other.last_value == first_value) ||
             other.last_value < first_value);
  }

  fn size() const -> usize {
    if (empty()) {
      return 0;
    }

    i128 count = static_cast<i128>(last_value) - static_cast<i128>(first_value);
    if (!exclude_last_value) {
      ++count;
    }
    return static_cast<usize>(count);
  }

  fn to_vec() const -> std::vector<T> {
    std::vector<T> result;
    result.reserve(size());
    for (T value : *this) {
      result.push_back(value);
    }
    return result;
  }

  fn to_rarray() const -> RArray<T> {
    RArray<T> result;
    result.reserve(size());
    for (T value : *this) {
      result.push_back(value);
    }
    return result;
  }

  fn begin() const -> Iterator { return Iterator(first_value); }

  fn end() const -> Sentinel {
    return Sentinel(last_value, exclude_last_value);
  }
};

/// [first, last] の範囲を表す RRange を作成する。
template <typename T> fn rrange(T first, T last) -> RRange<T> {
  return RRange<T>::inclusive(first, last);
}

/// [first, last) の範囲を表す RRange を作成する。
template <typename T> fn rexrange(T first, T last) -> RRange<T> {
  return RRange<T>::exclusive(first, last);
}

// ----- features/print.hpp -----


#ifdef ONLINE_JUDGE
#define NANACPP_PRINT_EOL '\n'
#else
#define NANACPP_PRINT_EOL std::endl
#endif

fn print() -> void { std::cout << NANACPP_PRINT_EOL; }
fn print(const std::string &s) -> void { std::cout << s << NANACPP_PRINT_EOL; }
fn print(const char *s) -> void { std::cout << s << NANACPP_PRINT_EOL; }
template <typename T> fn print(const T &value) -> void {
  std::cout << value << NANACPP_PRINT_EOL;
}
template <typename T> fn print(const std::vector<T> &vec) -> void {
  enumerate(x, i, vec) {
    std::cout << x;
    if (i + 1 != vec.size()) {
      std::cout << " ";
    }
  }
  std::cout << NANACPP_PRINT_EOL;
}
template <typename T, typename... Args>
fn print(const T &first, const Args &...args) -> void {
  std::cout << first;
  if constexpr (sizeof...(args) > 0) {
    std::cout << " ";
    print(args...);
  } else {
    std::cout << NANACPP_PRINT_EOL;
  }
}
template <typename T>
fn print(const std::vector<T> &vec, const std::string &sep) -> void {
  enumerate(x, i, vec) {
    std::cout << x;
    if (i + 1 != vec.size()) {
      std::cout << sep;
    }
  }
  std::cout << NANACPP_PRINT_EOL;
}

// ----- main.cpp -----

fn main() -> int {
  std::cout << std::fixed << std::setprecision(15);

  // your code here...
}
