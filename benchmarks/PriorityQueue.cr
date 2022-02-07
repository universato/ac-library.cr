# ac-library.cr by hakatashi https://github.com/google/ac-library.cr
#
# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "../src/PriorityQueue.cr"
require "spec"
require "benchmark"

Benchmark.bm do |x|
  # O(nlogn)
  x.report("AtCoder::PriorityQueue") do
    n = 500000
    q = AtCoder::PriorityQueue(Int32).new
    n.times do |i|
      q << i
      q << i + n
      q << i + n * 2
    end
    (n * 3).times do |i|
      q.pop.should eq n * 3 - i - 1
    end
  end
end
