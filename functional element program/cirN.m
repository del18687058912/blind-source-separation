function  A  = cirN (N,varargin)
%   varargin ��ʾ������ת����������������Ŀ��ȷ��������Ϊ2��3��4��
%   N��ʾ��Ͼ����ά��������Ϊ2��3��4��
%   ���������N��varargin��������ת����A��
    switch N            %����N��ֵȷ����Ͼ����ά��
        case 2            %��ά�����
            t1 = [cos(varargin{1}),-sin(varargin{1});
                sin(varargin{1}),cos(varargin{1})];
            A = t1 ;            
        case 3              %��ά�����
            t1 = [1,0,0;
                0,cos(varargin{1}),-sin(varargin{1});
                0,sin(varargin{1}),cos(varargin{1})];
            t2 = [cos(varargin{2}),0,-sin(varargin{2});
                0,1,0;
                sin(varargin{2}),0,cos(varargin{2})];
            t3 = [cos(varargin{3}),-sin(varargin{3}),0;
                sin(varargin{3}),cos(varargin{3}),0;
                0,0,1];
            A = t1 * t2 * t3;
        case 4              %��ά�����
            t1 = [1,0,0,0;
            0,1,0,0,;
            0,0,cos(varargin{1}),-sin(varargin{1});
            0,0,sin(varargin{1}),cos(varargin{1})];
            t2 = [cos(varargin{2}),0,-sin(varargin{2}),0;
            0,1,0,0;
            sin(varargin{2}),0,cos(varargin{2}),0;
            0,0,0,1];
            t3 = [cos(varargin{3}),-sin(varargin{3}),0,0;
            sin(varargin{3}),cos(varargin{3}),0,0;
            0,0,1,0;
            0,0,0,1];
            t4=[1,0,0,0;
            0,cos(varargin{4}),-sin(varargin{4}),0;
            0,sin(varargin{4}),cos(varargin{4}),0;
            0,0,0,1];
            t5=[1,0,0,0;
            0,cos(varargin{5}),0,-sin(varargin{5});
            0,0,1,0;
            0,sin(varargin{5}),0,cos(varargin{5}); ];
            t6=[cos(varargin{6}),0,0,-sin(varargin{6});
            0,1,0,0;
            0,0,1,0;
            sin(varargin{6}),0,0,cos(varargin{6});];
            A = t1 * t2 * t3* t4 * t5 * t6;
    end            
end

