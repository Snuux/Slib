<h2 id="slib">Slib</h2>

<p>Easy saving in Love2D!</p>

<hr>

<p>Go to <a href="https://github.com/Snuux/Slib/wiki">wiki</a>, for <a href="https://github.com/Snuux/Slib/wiki/Documentation">documentation</a> and <a href="https://github.com/Snuux/Slib/wiki/Tutorial">tutorial</a>!</p>

<p>Hi! My name is Vadim, and I create new library for easy save and load tables in your game.</p>

<p><strong>Slib</strong> can <strong>encrypt</strong> your save file! And if player don’t have <strong>special key</strong>, and <strong>alghoritm</strong> for decryption, he can’t change save file. <br>
If you need, Slib can create <strong>more than one</strong> files. And in Slib you can manage <strong>encryption specal key</strong> yourself.</p>

<p>In benchmark I use not single table. I use table in table (for example).</p>

<hr>

<p>Simple example:</p><div class="se-section-delimiter"></div>

<pre class="prettyprint prettyprinted" style=""><code class="language-lua"><span class="pln">    </span><span class="pun">--</span><span class="typ">While</span><span class="pln"> you </span><span class="kwd">exit</span><span class="pln"> </span><span class="kwd">from</span><span class="pln"> app</span><span class="pun">,</span><span class="pln"> data save</span><span class="pun">.</span><span class="pln"> </span><span class="typ">And</span><span class="pln"> </span><span class="kwd">while</span><span class="pln"> you will open </span><span class="kwd">this</span><span class="pun">,</span><span class="pln"> data load
    </span><span class="typ">Slib</span><span class="pln"> </span><span class="pun">=</span><span class="pln"> </span><span class="kwd">require</span><span class="pln"> </span><span class="str">"slib"</span><span class="pln">

    </span><span class="kwd">function</span><span class="pln"> love</span><span class="pun">.</span><span class="pln">load</span><span class="pun">()</span><span class="pln">
        </span><span class="typ">Slib</span><span class="pun">.</span><span class="pln">init</span><span class="pun">(</span><span class="str">"Slib"</span><span class="pun">)</span><span class="pln">

        </span><span class="kwd">if</span><span class="pln"> </span><span class="typ">Slib</span><span class="pun">.</span><span class="pln">isFirstSave</span><span class="pun">()</span><span class="pln"> </span><span class="kwd">then</span><span class="pln"> </span><span class="pun">--</span><span class="kwd">if</span><span class="pln"> there </span><span class="kwd">is</span><span class="pln"> </span><span class="kwd">no</span><span class="pln"> save
            g </span><span class="pun">=</span><span class="pln"> </span><span class="pun">{}</span><span class="pln"> </span><span class="pun">--</span><span class="kwd">char</span><span class="pln"> stats
            g</span><span class="pun">.</span><span class="pln">hp </span><span class="pun">=</span><span class="pln"> </span><span class="lit">50</span><span class="pln">
            g</span><span class="pun">.</span><span class="pln">dmg </span><span class="pun">=</span><span class="pln"> </span><span class="lit">100</span><span class="pln">
            g</span><span class="pun">.</span><span class="kwd">def</span><span class="pln"> </span><span class="pun">=</span><span class="pln"> </span><span class="lit">10</span><span class="pln">
        </span><span class="kwd">else</span><span class="pln"> </span><span class="pun">--</span><span class="kwd">if</span><span class="pln"> there </span><span class="kwd">is</span><span class="pln"> save file
            g </span><span class="pun">=</span><span class="pln"> </span><span class="typ">Slib</span><span class="pun">.</span><span class="pln">load</span><span class="pun">()</span><span class="pln"> 
        </span><span class="kwd">end</span><span class="pln">
    </span><span class="kwd">end</span><span class="pln">

    </span><span class="kwd">function</span><span class="pln"> love</span><span class="pun">.</span><span class="pln">update</span><span class="pun">(</span><span class="pln">dt</span><span class="pun">)</span><span class="pln">
        </span><span class="kwd">if</span><span class="pln"> love</span><span class="pun">.</span><span class="pln">keyboard</span><span class="pun">.</span><span class="pln">isDown</span><span class="pun">(</span><span class="str">'g'</span><span class="pun">)</span><span class="pln"> </span><span class="kwd">then</span><span class="pln">
            g</span><span class="pun">.</span><span class="pln">hp </span><span class="pun">=</span><span class="pln"> math</span><span class="pun">.</span><span class="pln">random</span><span class="pun">(</span><span class="lit">10</span><span class="pun">,</span><span class="pln"> </span><span class="lit">5000</span><span class="pun">)</span><span class="pln"> </span><span class="pun">--</span><span class="pln">generate </span><span class="kwd">new</span><span class="pln"> stats
            g</span><span class="pun">.</span><span class="pln">dmg </span><span class="pun">=</span><span class="pln"> math</span><span class="pun">.</span><span class="pln">random</span><span class="pun">(</span><span class="lit">10</span><span class="pun">,</span><span class="pln"> </span><span class="lit">5000</span><span class="pun">)</span><span class="pln">
            g</span><span class="pun">.</span><span class="kwd">def</span><span class="pln"> </span><span class="pun">=</span><span class="pln"> math</span><span class="pun">.</span><span class="pln">random</span><span class="pun">(</span><span class="lit">10</span><span class="pun">,</span><span class="pln"> </span><span class="lit">5000</span><span class="pun">)</span><span class="pln">
            </span><span class="typ">Slib</span><span class="pun">.</span><span class="pln">saveE</span><span class="pun">(</span><span class="pln">g</span><span class="pun">)</span><span class="pln"> </span><span class="pun">--</span><span class="pln">save stats </span><span class="kwd">with</span><span class="pln"> encription
        </span><span class="kwd">end</span><span class="pln">
    </span><span class="kwd">end</span><span class="pln">

    </span><span class="kwd">function</span><span class="pln"> love</span><span class="pun">.</span><span class="pln">draw</span><span class="pun">()</span><span class="pln">
        </span><span class="pun">--</span><span class="pln">draw </span><span class="kwd">our</span><span class="pln"> stats</span><span class="pun">:</span><span class="pln">
        love</span><span class="pun">.</span><span class="pln">graphics</span><span class="pun">.</span><span class="kwd">print</span><span class="pun">(</span><span class="str">"HP: "</span><span class="pln"> </span><span class="pun">..</span><span class="pln"> g</span><span class="pun">.</span><span class="pln">hp </span><span class="pun">..</span><span class="pln"> </span><span class="str">" Dmg: "</span><span class="pln"> </span><span class="pun">..</span><span class="pln"> g</span><span class="pun">.</span><span class="pln">dmg </span><span class="pun">..</span><span class="pln"> </span><span class="str">" Def: "</span><span class="pln"> </span><span class="pun">..</span><span class="pln"> g</span><span class="pun">.</span><span class="kwd">def</span><span class="pun">,</span><span class="pln"> </span><span class="lit">10</span><span class="pun">,</span><span class="pln"> </span><span class="lit">10</span><span class="pun">)</span><span class="pln">

        love</span><span class="pun">.</span><span class="pln">graphics</span><span class="pun">.</span><span class="kwd">print</span><span class="pun">(</span><span class="str">"Press G to generate random HP, Dmg, Def, and save them!"</span><span class="pun">,</span><span class="pln"> </span><span class="lit">10</span><span class="pun">,</span><span class="pln"> </span><span class="lit">30</span><span class="pun">)</span><span class="pln">
    </span><span class="kwd">end</span></code></pre>

<p>And it is example’s save file: <strong>Vf-Zq3SI?k<span class="MathJax_Preview"></span><span class="MathJax" id="MathJax-Element-127-Frame" role="textbox" aria-readonly="true" style=""><nobr><span class="math" id="MathJax-Span-1289" style="width: 7.572em; display: inline-block;"><span style="display: inline-block; position: relative; width: 5.653em; height: 0px; font-size: 134%;"><span style="position: absolute; clip: rect(1.335em 1000.003em 2.561em -0.424em); top: -2.183em; left: 0.003em;"><span class="mrow" id="MathJax-Span-1290"><span class="mi" id="MathJax-Span-1291" style="font-family: MathJax_Math; font-style: italic;">Z<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.056em;"></span></span><span class="mi" id="MathJax-Span-1292" style="font-family: MathJax_Math; font-style: italic;">m</span><span class="mn" id="MathJax-Span-1293" style="font-family: MathJax_Main;">6</span><span class="mi" id="MathJax-Span-1294" style="font-family: MathJax_Math; font-style: italic;">P<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.109em;"></span></span><span class="mi" id="MathJax-Span-1295" style="font-family: MathJax_Math; font-style: italic;">N<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.109em;"></span></span><span class="mi" id="MathJax-Span-1296" style="font-family: MathJax_Math; font-style: italic;">f<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.056em;"></span></span><span class="mi" id="MathJax-Span-1297" style="font-family: MathJax_Math; font-style: italic;">b</span><span class="mo" id="MathJax-Span-1298" style="font-family: MathJax_Main; padding-left: 0.269em;">"</span></span><span style="display: inline-block; width: 0px; height: 2.188em;"></span></span></span><span style="border-left-width: 0.004em; border-left-style: solid; display: inline-block; overflow: hidden; width: 0px; height: 1.361em; vertical-align: -0.354em;"></span></span></nobr></span><script type="math/tex" id="MathJax-Element-127">Zm6PNfb"</script>w0RUXla-xlDk&amp;<code>Rk&amp;PbT)]&amp;2l</code>~_n}BB</strong></p>

<p>In repository you can find benchmark, and more usefull example!</p>