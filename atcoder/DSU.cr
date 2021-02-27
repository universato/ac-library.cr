# ac-library.cr by hakatashi https://github.com/google/ac-library.cr
#
# Copyright 2021 Google LLC
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

module AtCoder
  class DSU
    getter parents : Array(Int64)
    getter sizes : Array(Int64)
    getter size : Int64

    def initialize(@size)
      @parents = Array.new(size, &.to_i64)
      @sizes = Array.new(size, 1_i64)
    end

    def leader(node)
      until @parents[node] == node
        @parents[node] = @parents[@parents[node]]
        node = @parents[node]
      end
      node
    end

    def merge(a, b)
      leader_a = leader(a.to_i64)
      leader_b = leader(b.to_i64)
      unless leader_a == leader_b
        if @sizes[leader_a] < @sizes[leader_b]
          leader_a, leader_b = leader_b, leader_a
        end
        @parents[leader_b] = leader_a
        @sizes[leader_a] += @sizes[leader_b]
      end
    end

    def same(a, b)
      leader(a) == leader(b)
    end

    def size(node)
      @sizes[leader(node)]
    end

    def groups
      groups = Hash(Int64, Set(Int64)).new {|h, k| h[k] = Set(Int64).new}
      @size.times do |i|
        groups[leader(i)] << i
      end
      groups.values.to_set
    end
  end
end
