

# Module marina_request #
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)



<a name="types"></a>

## Data Types ##




### <a name="type-consistency">consistency()</a> ###



<pre><code>
consistency() = 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 16
</code></pre>





### <a name="type-flag">flag()</a> ###



<pre><code>
flag() = {skip_metadata, boolean()} | {values, boolean()}
</code></pre>





### <a name="type-frame_flag">frame_flag()</a> ###



<pre><code>
frame_flag() = {compression, boolean()}
</code></pre>





### <a name="type-query">query()</a> ###



<pre><code>
query() = binary()
</code></pre>





### <a name="type-statement_id">statement_id()</a> ###



<pre><code>
statement_id() = binary()
</code></pre>





### <a name="type-stream">stream()</a> ###



<pre><code>
stream() = 0..32768
</code></pre>


<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#execute-6">execute/6</a></td><td></td></tr><tr><td valign="top"><a href="#prepare-3">prepare/3</a></td><td></td></tr><tr><td valign="top"><a href="#query-5">query/5</a></td><td></td></tr><tr><td valign="top"><a href="#startup-1">startup/1</a></td><td></td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="execute-6"></a>

### execute/6 ###


<pre><code>
execute(Stream::<a href="#type-stream">stream()</a>, FrameFlags::[<a href="#type-frame_flag">frame_flag()</a>], StatementId::<a href="#type-statement_id">statement_id()</a>, Values::[binary()], ConsistencyLevel::<a href="#type-consistency">consistency()</a>, Flags::[<a href="#type-flag">flag()</a>]) -&gt; binary()
</code></pre>
<br />


<a name="prepare-3"></a>

### prepare/3 ###


<pre><code>
prepare(Stream::<a href="#type-stream">stream()</a>, FrameFlags::[<a href="#type-frame_flag">frame_flag()</a>], Query::<a href="#type-query">query()</a>) -&gt; binary()
</code></pre>
<br />


<a name="query-5"></a>

### query/5 ###


<pre><code>
query(Stream::<a href="#type-stream">stream()</a>, FrameFlags::[<a href="#type-frame_flag">frame_flag()</a>], Query::<a href="#type-query">query()</a>, ConsistencyLevel::<a href="#type-consistency">consistency()</a>, Flags::[<a href="#type-flag">flag()</a>]) -&gt; binary()
</code></pre>
<br />


<a name="startup-1"></a>

### startup/1 ###


<pre><code>
startup(FrameFlags::[<a href="#type-frame_flag">frame_flag()</a>]) -&gt; binary()
</code></pre>
<br />

